#!/usr/bin/env bash

echo "$1"

commit_message_file="$1"

commit_message=$(cat "$1")

echo $commit_message

branch_name=$(git branch --show-current)

echo $branch_name

IFS='-' read -ra parts <<< "$branch_name"

if [ "${#parts[@]}" -ge 3 ]; then
  extracted_part="[${parts[1]}-${parts[2]}]"
  echo $extracted_part
else
  echo "Invalid string format"
fi

new_commit_message="$extracted_part $commit_message"

echo "$new_commit_message" > "$commit_message_file"