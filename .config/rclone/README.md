# Owncloud Sync Setup (via Rclone)

This directory manages a robust, bidirectional synchronization between the local `~/owncloud/` directory and the Nextcloud server using `rclone bisync`.

## 1. Prerequisites

Ensure the following packages are installed:

```bash
sudo pacman -S rclone inotifywait
```

## 2. Configuration

1. **Initialize Rclone:**
   ```bash
   rclone config
   ```
   - Create a new remote named `owncloud_fkeilholz`.
   - Type: `webdav`.
   - URL: `https://keilholz.biz/cloud/remote.php/dav/files/fkeilholz/`
   - Vendor: `owncloud`.
   - PW: `pw` -> will be remapped into differnt string -> not encrypted just 'soulder' secure
     Find the resulting vonfig in `~/.config/rclone/rclone.conf`.

## 3. Automation Setup

The synchronization is managed by a Systemd user service.

1. **Install files to local system:**

   ```bash
   # Ensure the binary folder exists
   mkdir -p ~/.local/bin

   # Symlink the sync script and service file
   ln -sf ~/.config/rclone/sync-robust.sh ~/.local/bin/sync-robust.sh
   mkdir -p ~/.config/systemd/user/
   ln -sf ~/.config/rclone/rclone-bisync.service ~/.config/systemd/user/rclone-bisync.service
   ```

2. **Start the service:**
   ```bash
   systemctl --user daemon-reload
   systemctl --user enable --now rclone-bisync.service
   ```

## 4. Maintenance & Troubleshooting

- **Check Status:** `systemctl --user status rclone-bisync`
- **View Sync Logs:** `tail -f ~/.cache/rclone-bisync.log`
- **Manual Resync (if conflicts occur):**
  If `bisync` reports errors or database conflicts, reset the sync state:
  ```bash
  systemctl --user stop rclone-bisync
  rm -rf /home/franz/.cache/rclone/bisync/*
  rclone bisync /home/franz/owncloud/ owncloud_fkeilholz: --resync --conflict-resolve newer --check-access --verbose
  systemctl --user start rclone-bisync
  ```

## 5. Security Note

- The `rclone.conf` is stored in this directory.
- It is **ignored by Git** (see `.gitignore`) to prevent leaking credentials to the repository.
- The disk is encrypted with **LUKS**, ensuring local data protection at rest.
