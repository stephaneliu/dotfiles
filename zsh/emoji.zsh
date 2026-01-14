#!/bin/bash
#
# Usage: emoji <search_term>
#
# Fetches a list of emojis and allows searching and copying to clipboard. If the search_term returns multiple, the
# closest match is copied and alternatives are shown.
#
# If no search_term is provided, an interactive fzf menu is shown to select an emoji.

_get_emojis() {
  local cache_file="/tmp/emoji_cache.txt"
  local ttl=604800  # 1 week in seconds

  if [[ -f "$cache_file" ]]; then
    local file_age=$(( $(date +%s) - $(date -r "$cache_file" +%s) ))
    if (( file_age < ttl )); then
      cat "$cache_file"
      return
    fi
  fi

  local emojis=$(curl -sSL 'https://git.io/JXXO7')
  echo "$emojis" > "$cache_file"
  echo "$emojis"
}

emoji() {
  emojis=$(_get_emojis)
  local search="${1%% }"
  search="${search%\\}"
  if [[ -n "$search" ]]; then
    local matches=$(echo "$emojis" | grep -i "$search" | sort -t: -k2)
    if [[ -n "$matches" ]]; then
      selected_emoji=$(echo "$matches" | head -1 | cut -d' ' -f1)
      echo -n "$selected_emoji" | pbcopy
      echo "Copied $selected_emoji to clipboard"
      local alternatives=$(echo "$matches" | tail -n +2)
      if [[ -n "$alternatives" ]]; then
        echo "Alternatives:"
        echo "$alternatives"
      fi
    else
      echo "No emoji found matching '$search'"
    fi
  else
    selected_emoji=$(echo $emojis | fzf)
    echo $selected_emoji
  fi
}

alias em=emoji

# em white<tab><tab> -> complete emoji names
_emoji_completion() {
  local cache_file="/tmp/emoji_cache.txt"
  local emojis
  if [[ -f "$cache_file" ]]; then
    emojis=$(cat "$cache_file")
  else
    emojis=$(curl -sSL 'https://git.io/JXXO7' 2>/dev/null)
    echo "$emojis" > "$cache_file"
  fi
  local search="${words[2]:-}"
  local -a matches
  matches=(${(f)"$(echo "$emojis" | grep -i "$search" | sed 's/.*:\([^:]*\):/\1/' | sort)"})
  compadd -Q -M 'l:|=* r:|=*' -a matches
}

compdef _emoji_completion emoji em
