#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: project.sh <directory-name>"
    echo "Opens a tmux session for a project in ~/Projects/<directory-name>"
    exit 1
fi

SESSION_NAME="$1"
PROJECT_DIR="$HOME/Projects/$1"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Directory $PROJECT_DIR does not exist."
    exit 1
fi

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

# Window 2: shell
tmux new-window -t "$SESSION_NAME" -c "$PROJECT_DIR" -n "shell"

# Select Window 1 to start
tmux select-window -t "$SESSION_NAME:ai"

# Attach to the session
if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach-session -t "$SESSION_NAME"
fi
