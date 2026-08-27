#!/bin/bash

# StatusLine script that mimics Powerlevel10k style
# Based on user's p10k configuration with os_icon, dir, vcs segments

# Read Claude context from stdin
CLAUDE_CONTEXT=$(cat)

# Extract working directory from Claude context
WORKING_DIR=$(echo "$CLAUDE_CONTEXT" | jq -r '.cwd // .workspace.current_dir // ""')

# If we can't get the directory from Claude context, use pwd as fallback
if [[ -z "$WORKING_DIR" ]]; then
    WORKING_DIR=$(pwd)
fi

# Extract git info from Claude context (fallback to actual git commands if not available)
GIT_BRANCH=$(echo "$CLAUDE_CONTEXT" | jq -r '.gitStatus.currentBranch // ""' 2>/dev/null)
if [[ -z "$GIT_BRANCH" ]] && git rev-parse --git-dir > /dev/null 2>&1; then
    GIT_BRANCH=$(git branch --show-current 2>/dev/null)
fi

# Extract model info
MODEL_NAME=$(echo "$CLAUDE_CONTEXT" | jq -r '.model.display_name // .model.id // ""' 2>/dev/null)
if [[ -z "$MODEL_NAME" ]]; then
    MODEL_NAME="Claude"
fi

# Extract token usage
INPUT_TOKENS=$(echo "$CLAUDE_CONTEXT" | jq -r '.context_window.total_input_tokens // 0' 2>/dev/null)
OUTPUT_TOKENS=$(echo "$CLAUDE_CONTEXT" | jq -r '.context_window.total_output_tokens // 0' 2>/dev/null)
CONTEXT_PCT=$(echo "$CLAUDE_CONTEXT" | jq -r '.context_window.used_percentage // 0' 2>/dev/null | cut -d. -f1)

# Format token counts (add K suffix for thousands)
format_tokens() {
    local tokens=$1
    if [[ $tokens -ge 1000000 ]]; then
        printf "%.1fM" $(echo "scale=1; $tokens/1000000" | bc)
    elif [[ $tokens -ge 1000 ]]; then
        printf "%.1fK" $(echo "scale=1; $tokens/1000" | bc)
    else
        echo "$tokens"
    fi
}

FORMATTED_IN=$(format_tokens "$INPUT_TOKENS")
FORMATTED_OUT=$(format_tokens "$OUTPUT_TOKENS")

# OS icon (matching p10k style)
OS_ICON="󰍛"

# Format directory path (abbreviate home directory)
if [[ "$WORKING_DIR" == "$HOME"* ]]; then
    DIR_DISPLAY="~${WORKING_DIR#$HOME}"
else
    DIR_DISPLAY="$WORKING_DIR"
fi

# Truncate very long paths
if [[ ${#DIR_DISPLAY} -gt 50 ]]; then
    DIR_DISPLAY="...${DIR_DISPLAY: -47}"
fi

# Build the statusline
STATUSLINE="$OS_ICON $DIR_DISPLAY"

# Add git branch if available
if [[ -n "$GIT_BRANCH" ]]; then
    STATUSLINE="$STATUSLINE  $GIT_BRANCH"
fi

# Add model name
if [[ -n "$MODEL_NAME" ]]; then
    STATUSLINE="$STATUSLINE  $MODEL_NAME"
fi

# Add token usage
STATUSLINE="$STATUSLINE  ${FORMATTED_IN}↓/${FORMATTED_OUT}↑ (${CONTEXT_PCT}%)"

echo "$STATUSLINE"