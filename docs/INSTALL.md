# Installation notes

## Supported target

AKKAD targets Arch Linux and Arch-based distributions using pacman. It uses Hyprland 0.55+ Lua configuration and Quickshell 0.3+ QML shell APIs.

## What the installer changes

- Installs the packages listed in `packages/base.txt` after confirmation.
- Backs up existing target folders, including any existing `~/.config/quickshell`.
- Copies AKKAD application configuration into `~/.config`.
- Creates a separate task-data directory at `~/.local/share/akkad-shell` without overwriting an existing task file.
- Keeps the managed Git checkout at `~/.local/share/akkad`.
- Installs `akkad`, `akkad-shell`, `akkad-update` and `akkad-doctor` into `~/.local/bin`.

## What it deliberately does not change

- Wallpaper files or existing wallpaper configuration.
- Display manager, auto-login, bootloader, kernel, or initramfs.
- GPU drivers or kernel parameters.
- Existing desktop environments or their packages.
- Existing network manager configuration or service enablement.
- User tasks stored in `~/.local/share/akkad-shell/tasks.json`.

## Session startup

Select the Hyprland session from your display manager. AKKAD starts Quickshell through Hyprland's `hyprland.start` event. Waybar is installed as an optional fallback but is not started, so it does not appear alongside the centered AKKAD navbar.

For a TTY session:

```bash
start-hyprland
```

The install script does not change display-manager settings or enable automatic login.

## Shell controls

```bash
akkad -s                # Start now
akkad -r                # Restart
akkad -x                # Stop for this session
akkad --disable-shell   # Stop and disable automatic startup
akkad --enable-shell    # Re-enable automatic startup and start
```

## Data locations

- Shell config: `~/.config/quickshell/akkad/`
- Task data: `~/.local/share/akkad-shell/tasks.json`
- Config backups: `~/.local/state/akkad/backups/`
- Update backups: `~/.local/state/akkad/update-backups/`

## Notes

The initial placement is tuned for a 1920×1080 single-monitor laptop. Sensor availability varies by hardware and kernel; unavailable temperature values appear as unavailable. Media controls depend on the capabilities exposed by each MPRIS player.
