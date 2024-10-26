#!/bin/bash
# Shared Bash Functions

screen_quit() {
    if [ -z "$1" ]; then
        echo "Usage: screen_quit <session_name>"
        return 1
    fi
    screen -X -S "$1" quit
}
