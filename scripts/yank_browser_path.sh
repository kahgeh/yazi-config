#!/bin/bash
output=""
for f in "$@"; do
    if [ -n "$output" ]; then
        output="$output"$'\n'"file://$f"
    else
        output="file://$f"
    fi
done
printf "%s" "$output" | pbcopy
