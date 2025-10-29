#!/bin/bash

# Bash function to fetch GitHub mentions
# Add this to your .bashrc or .zshrc to use it as a command

gment() {
  echo "Fetching your GitHub @mentions..."
  echo ""

  # Fetch notifications for mentions, sort, and process
  local mentions=$(gh api --paginate '/notifications' \
    --jq '.[] | select(.reason == "mention") | {
      title: .subject.title,
      repo: .repository.full_name,
      updated: .updated_at,
      url: .subject.url,
      type: .subject.type,
      thread_id: .id
    }' | jq -s 'sort_by(.updated) | reverse | .[]' -c)

  # Check if there are any mentions
  if [[ -z "$mentions" ]]; then
    echo "Cool - no new mentions. Go write some code! 🚀"
    return
  fi

  # Process mentions
  echo "$mentions" | while IFS= read -r line; do
    # Parse JSON object
    title=$(echo "$line" | jq -r '.title')
    repo=$(echo "$line" | jq -r '.repo')
    updated=$(echo "$line" | jq -r '.updated')
    api_url=$(echo "$line" | jq -r '.url')
    type=$(echo "$line" | jq -r '.type')
    thread_id=$(echo "$line" | jq -r '.thread_id')

    # Convert API URL to web URL
    if [[ "$type" == "PullRequest" ]]; then
      web_url=$(echo "$api_url" | sed 's|api.github.com/repos|github.com|' | sed 's|/pulls/|/pull/|')
    elif [[ "$type" == "Issue" ]]; then
      web_url=$(echo "$api_url" | sed 's|api.github.com/repos|github.com|')
    else
      web_url=$(echo "$api_url" | sed 's|api.github.com/repos|github.com|')
    fi

    # Format the date
    formatted_date=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$updated" "+%B %d, %Y at %I:%M %p" 2>/dev/null || echo "$updated")

    # Print formatted output
    echo "• $title"
    echo "  Repository: $repo"
    echo "  Updated: $formatted_date"
    echo "  URL: $web_url"
    echo "  Thread ID: $thread_id"
    echo ""
  done
}

# If script is executed directly (not sourced), run the function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  gment
fi
