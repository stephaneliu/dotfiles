#!/bin/bash

emoji() {
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  if [[ -n "$1" ]]; then
    local exact_match=$(echo "$emojis" | grep -i ":${1}:")
    local partial_matches=$(echo "$emojis" | grep -i "$1" | grep -iv ":${1}:")
    if [[ -n "$exact_match" ]]; then
      selected_emoji=$(echo "$exact_match" | head -1 | cut -d' ' -f1)
      echo -n "$selected_emoji" | pbcopy
      echo "Copied $selected_emoji to clipboard"
      local alternatives=$(echo -e "${exact_match}\n${partial_matches}" | tail -n +2)
      if [[ -n "$alternatives" ]]; then
        echo "Alternatives:"
        echo "$alternatives"
      fi
    elif [[ -n "$partial_matches" ]]; then
      selected_emoji=$(echo "$partial_matches" | head -1 | cut -d' ' -f1)
      echo -n "$selected_emoji" | pbcopy
      echo "Copied $selected_emoji to clipboard"
      local alternatives=$(echo "$partial_matches" | tail -n +2)
      if [[ -n "$alternatives" ]]; then
        echo "Alternatives:"
        echo "$alternatives"
      fi
    else
      echo "No emoji found matching '$1'"
    fi
  else
    selected_emoji=$(echo $emojis | fzf)
    echo $selected_emoji
  fi
}

alias em=emoji
