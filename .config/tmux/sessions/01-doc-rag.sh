#!/usr/bin/env bash

SESSION_NAME="01-doc-rag"
PROJECT_DIR="$HOME/Projects/01-doc-rag"

# Check if session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Session $SESSION_NAME already exists. Attaching to it."
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach-session -t "$SESSION_NAME"
    fi
    exit 0
fi

# Create a new detached session, starting in PROJECT_DIR
# Window 1: run opencode
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n "ai"
tmux send-keys -t "$SESSION_NAME:ai" "opencode" C-m

# Window 2: split 2-1
tmux new-window -t "$SESSION_NAME" -c "$PROJECT_DIR" -n "control"

# Pane 1 (top left)
tmux send-keys -t "$SESSION_NAME:control" "make docker" C-m

# Split horizontally to create top right pane (Pane 2)
tmux split-window -h -t "$SESSION_NAME:control" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:control" "tail -f logs/indexer.log" C-m

# Split vertically, full width, to create bottom row (Pane 3)
tmux split-window -v -f -t "$SESSION_NAME:control" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:control" "make grpcui" C-m

# Window 3: shell
tmux new-window -t "$SESSION_NAME" -c "$PROJECT_DIR" -n "shell"

# Select Window 2 to start
tmux select-window -t "$SESSION_NAME:control"

# Attach to the session
if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach-session -t "$SESSION_NAME"
fi
