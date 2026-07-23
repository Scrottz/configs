#!/bin/bash
MAIL_ROOT="$HOME/mail"

boxes=(
    "Posteo:$MAIL_ROOT/posteo/INBOX/new/"
    "Main:$MAIL_ROOT/main/INBOX/new/"
    "Github:$MAIL_ROOT/github/INBOX/new/"
    "Spam:$MAIL_ROOT/spam/INBOX/new/"
)

out=""
for b in "${boxes[@]}"; do
    name="${b%%:*}"
    path="${b#*:}"

    count=$(find "$path" -maxdepth 0 -empty 2>/dev/null || ls -1q "$path" | wc -l)

    count=$(ls -1q "$path" 2>/dev/null | wc -l)

    if [ "$count" -gt 0 ]; then
        out="${out} ${name}:$count"
    fi
done

if [ -z "${out// }" ]; then
    echo "{\"text\": \"¯\\\\_(ツ)_/¯\"}"
else
    echo "{\"text\": \"$out\"}"
fi
