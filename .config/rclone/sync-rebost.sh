#!/bin/bash

# Configuration
LOCAL="/home/franz/owncloud/"
REMOTE="owncloud_franz:"
LOG="/home/franz/.cache/rclone-bisync.log"

# Rclone flags:
# --conflict-resolve newest: Keep the version with the latest timestamp
# --check-access: Verify server availability before starting
# --verbose: Detailed output for logging
FLAGS="--conflict-resolve newest --check-access --verbose --log-file $LOG"

echo "Sync-Daemon started at $(date)" >> $LOG

while true; do
    # Run the bidirectional sync
    rclone bisync "$LOCAL" "$REMOTE" $FLAGS

    # Check if the sync failed
    if [ $? -ne 0 ]; then
        echo "Sync failed, retrying in 60 seconds..." >> $LOG
        sleep 60
    else
        # Wait for file system changes in the local directory
        # -e: monitor these events | -r: recursive
        inotifywait -r -e modify,create,delete,move,attrib "$LOCAL"

        # Short buffer to ensure file operations are complete
        sleep 3
    fi
done
