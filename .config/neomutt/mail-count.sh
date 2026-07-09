#!/bin/bash

# Define the root directory for all mail accounts
MAIL_ROOT="$HOME/mail"

# Function to count new emails
count_new() {
    find "$1/new/" -type f 2>/dev/null | wc -l
}

# Define keys and values in separate arrays to enforce strict order
# Order: Posteo, Main, Git, Spam
names=("Posteo" "Main" "Git" "Spam")
paths=("posteo/INBOX" "main/INBOX" "github/INBOX" "spam/INBOX")

out=""

# Loop through the indices of the arrays
for i in "${!names[@]}"; do
    num=$(count_new "$MAIL_ROOT/${paths[$i]}")

    # If the count is greater than 0, append the info
    if [ "$num" -gt 0 ]; then
        out="${out} 󰇮 ${names[$i]}: $num "
    fi
done

# Output the result or the shrug if empty
if [ -z "$out" ]; then
    echo "¯\_(ツ)_/¯"
else
    echo "$out"
fi

