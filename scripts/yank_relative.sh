#!/bin/bash
output=""
for f in "$@"; do
    r="$(git -C "$(dirname "$f")" rev-parse --show-toplevel 2>/dev/null)"
    if [ -n "$r" ]; then
        rel="${f#"$r"/}"
    else
        rel="$f"
    fi
    if [ -n "$output" ]; then
        output="$output"$'\n'"$rel"
    else
        output="$rel"
    fi
done
printf "%s" "$output" | pbcopy
