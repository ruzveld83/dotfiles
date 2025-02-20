export LANG=en_US.UTF-8

function jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        if [ "$2" != "silent" ]
        then
                java -version
        fi
}

jdk 17 silent

# usage: compress_videos "*.mp4"
compress_videos() {
    local template="$1"
    
    for file in $(find . -maxdepth 1 -type f -name "$template"); do
        local full_file_name=$(basename "$file")
        local short_file_name=$(echo "$full_file_name" | cut -d. -f1)
        ffmpeg -i "$full_file_name" -c:v libx264 -crf 33 -preset medium -c:a copy "${short_file_name}_c.mp4"
    done
}

alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

export M2_HOME=/usr/local/Cellar/maven/3.8.2/libexec
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/ant@1.9/bin:/usr/local/sbin:$(brew --prefix python)/libexec/bin:$(brew --prefix ruby)/bin:$PATH"
