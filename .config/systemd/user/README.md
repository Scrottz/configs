# Mail Synchronization with mbsync & systemd

This setup uses `mbsync` (isync) to synchronize your mail accounts and `systemd` user services to keep them updated in the background.

## 1. Setup Structure
Ensure your configuration file is located at:
`~/.config/isync/mbsyncrc`

## 2. Systemd Service & Timer
Copy the following files to `~/.config/systemd/user/`:

### `mbsync.service`
```ini
[Unit]
Description=Mailbox synchronization service

[Service]
Type=oneshot
ExecStart=/usr/bin/mbsync -c %h/.config/isync/mbsyncrc -a
```

### `mbsync.timer`
```ini
[Unit]
Description=Mailbox synchronization timer

[Timer]
OnBootSec=2m
OnUnitActiveSec=5m
Unit=mbsync.service

[Install]
WantedBy=timers.target
```

## 3. Activation Commands
Run these commands to register and start the background synchronization:

```bash
# 1. Reload systemd to recognize the new files
systemctl --user daemon-reload

# 2. Enable the timer to start on boot
systemctl --user enable --now mbsync.timer

# 3. Start the sync manually once (optional)
systemctl --user start mbsync.service
```

## 4. Useful Management Commands

*   **Check status of the timer:**
    `systemctl --user status mbsync.timer`
*   **Check logs for errors:**
    `journalctl --user -u mbsync.service -n 20`
*   **Stop the sync timer:**
    `systemctl --user disable --now mbsync.timer`
*   **Manually trigger a sync:**
    `systemctl --user start mbsync.service`
