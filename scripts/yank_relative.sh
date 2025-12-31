#!/bin/bash
f="$1"
r="$(git -C "$(dirname "$f")" rev-parse --show-toplevel 2>/dev/null)"
if [ -n "$r" ]; then
    rel="${f#"$r"/}"
    printf "%s" "$rel" | pbcopy
else
    printf "%s" "$f" | pbcopy
fi
