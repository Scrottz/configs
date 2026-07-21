#!/bin/bash

run_segment() {
    MAIL_ROOT="$HOME/mail"
    names=("Posteo" "Main" "Github" "Spam")
    paths=("posteo/INBOX" "main/INBOX" "github/INBOX" "spam/INBOX")

    out=""
    for i in "${!names[@]}"; do
        num=$(find "$MAIL_ROOT/${paths[$i]}/new/" -type f 2>/dev/null | wc -l)
        if [ "$num" -gt 0 ]; then
            out="${out} ${names[$i]}:$num"
        fi
    done

    if [ -z "${out// }" ]; then
        echo "¯\_(ツ)_/¯"
    else
        echo "$out"
    fi
    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_segment
fi
