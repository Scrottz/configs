#!/bin/bash

# Start the mbsync service and wait for it to finish
# --wait ensures the script pauses until the sync is actually complete
systemctl --user start --wait mbsync.service >/dev/null 2>&1

# Update the notmuch index after sync is finished
notmuch new >/dev/null 2>&1 

