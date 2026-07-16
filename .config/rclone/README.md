# Rclone Bidirectional Sync (Bisync)

This folder contains the configuration and automation scripts for bidirectional synchronization between the local `~/owncloud/` directory and the Nextcloud server.

## 1. Prerequisites

Install the necessary tools:

```bash
sudo pacman -S rclone inotify-tools libsecret
```

## 2. Initial Configuration

1. **Configure rclone:**

   ```bash
   rclone config
   ```
   - Select `n` (New remote).
   - Name: `owncloud_franz`
   - Storage: Select `webdav`.
   - URL: `https://keilholz.biz/cloud/remote.php/dav/files/fkeilholz/`
   - Vendor: `nextcloud`
   - User: `fkeilholz`
   - Password: `y` (enter your password).
   - Leave other settings default.

2. **Secure Password Storage:**
   Store your credentials in the system keyring:
   ```bash
   secret-tool store --label='Nextcloud Password' host keilholz.biz user fkeilholz
   ```

## 3. Deployment

1. **Symlink the automation script:**

   ```bash
   ln -s ~/.config/rclone/sync-robust.sh ~/.local/bin/sync-robust.sh
   ```

2. **Symlink the Systemd service:**

   ```bash
   ln -s ~/.config/rclone/rclone-bisync.service ~/.config/systemd/user/rclone-bisync.service
   ```

3. **Enable the service:**
   ```bash
   systemctl --user daemon-reload
   systemctl --user enable --now rclone-bisync.service
   ```

## 4. Initial Sync (Run this ONCE)

Before starting the service permanently, perform the initial resync to establish the database:

```bash
rclone bisync /home/franz/owncloud/ owncloud_franz: --resync
```

## 5. Maintenance & Troubleshooting

- **Check Sync Status:**
  `systemctl --user status rclone-bisync`
- **View Logs:**
  `tail -f ~/.cache/rclone-bisync.log`
- **Fix Conflicts:**
  If the sync crashes or database conflicts occur:
  ```bash
  systemctl --user stop rclone-bisync
  rclone bisync /home/franz/owncloud/ owncloud_franz: --resync
  systemctl --user start rclone-bisync
  ```
