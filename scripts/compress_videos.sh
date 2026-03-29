
#!/bin/bash
# -----------------------------------------------------------------------------
# compress_videos.sh — Compress Samsung Galaxy S25 Ultra footage with ffmpeg
# Usage:  ./compress_videos.sh [file_mask]
# Examples:
#   ./compress_videos.sh            # processes *.mp4 in current directory
#   ./compress_videos.sh "*.mp4"
#   ./compress_videos.sh "VID_*.mp4"
# Output: same filename with _c suffix, e.g. VID_001.mp4 → VID_001_c.mp4
# -----------------------------------------------------------------------------

set -euo pipefail

MASK="${1:-*.mp4}"
CODEC="libx265"       # H.265 — best quality/size ratio; change to libx264 for wider compat
CRF=28                # 24–32 is the sweet spot; lower = better quality & larger file
PRESET="medium"         # slow/medium/fast — slower = better compression at same CRF
AUDIO_BITRATE="192k"  # 192 k is transparent for stereo; lower to 128k to save more space

# ── Counters ────────────────────────────────────────────────────────────────
processed=0
skipped=0
errors=0

echo "────────────────────────────────────────────────"
echo " Codec   : $CODEC  |  CRF: $CRF  |  Preset: $PRESET"
echo " Mask    : $MASK"
echo "────────────────────────────────────────────────"

shopt -s nullglob   # prevent literal glob string when no files match
files=( $MASK )
shopt -u nullglob

if [[ ${#files[@]} -eq 0 ]]; then
    echo "No files matched: $MASK"
    exit 0
fi

for f in "${files[@]}"; do
    [[ -f "$f" ]] || continue

    base="${f%.*}"
    ext="${f##*.}"
    output="${base}_c.${ext}"

    # Skip if output already exists
    if [[ -f "$output" ]]; then
        echo "⚠  SKIP  $f  (output already exists: $output)"
        (( skipped++ )) || true
        continue
    fi

    # Skip files that are already compressed outputs
    if [[ "$base" == *_c ]]; then
        echo "⚠  SKIP  $f  (looks like a previous output)"
        (( skipped++ )) || true
        continue
    fi

    orig_size=$(du -sh "$f" 2>/dev/null | cut -f1)
    echo ""
    echo "▶  $f  ($orig_size)"

    if ffmpeg -hide_banner -loglevel warning -stats \
        -i "$f" \
        -c:v "$CODEC" \
        -crf "$CRF" \
        -preset "$PRESET" \
        -tag:v hvc1 \
        -c:a aac \
        -b:a "$AUDIO_BITRATE" \
        -map_metadata 0 \
        -movflags +faststart \
        "$output"; then

        new_size=$(du -sh "$output" 2>/dev/null | cut -f1)
        orig_bytes=$(stat -f%z "$f"   2>/dev/null || stat -c%s "$f")
        new_bytes=$(stat  -f%z "$output" 2>/dev/null || stat -c%s "$output")
        ratio=$(awk "BEGIN { printf \"%.1f\", $orig_bytes/$new_bytes }")

        echo "✔  $output  ($new_size)  —  ${ratio}× smaller"
        (( processed++ )) || true
    else
        echo "✖  ERROR processing $f"
        rm -f "$output"   # remove partial output
        (( errors++ )) || true
    fi
done

echo ""
echo "────────────────────────────────────────────────"
echo " Done. Processed: $processed | Skipped: $skipped | Errors: $errors"
echo "────────────────────────────────────────────────"
