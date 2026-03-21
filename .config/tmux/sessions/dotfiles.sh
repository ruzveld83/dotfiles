#!/usr/bin/env bash

SESSION_NAME="dotfiles"
PROJECT_DIR="$HOME/dotfiles"

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

# Window 2: nvim
tmux new-window -t "$SESSION_NAME" -c "$PROJECT_DIR" -n "editor"
tmux send-keys -t "$SESSION_NAME:editor" "nvim ." C-m

# Select Window 1 to start
tmux select-window -t "$SESSION_NAME:ai"

# Attach to the session
if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach-session -t "$SESSION_NAME"
fi
