#!/bin/bash
MAIL_ROOT="$HOME/mail"

# Function to count files in the 'new/' directory
count_new() {
    find "$1/new/" -type f 2>/dev/null | wc -l
}

p=$(count_new "$MAIL_ROOT/posteo/INBOX")
m=$(count_new "$MAIL_ROOT/main/INBOX")
s=$(count_new "$MAIL_ROOT/spam/INBOX")
g=$(count_new "$MAIL_ROOT/github/INBOX")

out=""
[ "$p" -gt 0 ] && out="${out}P:$p "
[ "$m" -gt 0 ] && out="${out}M:$m "
[ "$s" -gt 0 ] && out="${out}S:$s "
[ "$g" -gt 0 ] && out="${out}G:$g "

# Output only if there is something to report
echo "$out"
