# AKKAD

**A Mesopotamian-inspired Arch Linux desktop environment built on Hyprland and Quickshell.**

AKKAD is an independent desktop project, separate from A16EEN. Its visual language draws from ancient imperial architecture, carved stone, astronomy, seals and bronze instruments — interpreted as a restrained modern interface rather than a generic gaming HUD.

## Current shell

The first usable shell layout includes:
- A miniature centered navbar with real Hyprland workspace indicators.
- An astronomical clock and live system date.
- A left-side monitor for CPU, memory, storage, temperature when exposed, and network throughput.
- A persistent task ledger with add, edit, complete, delete and due dates.
- A live monthly calendar marking dates with pending tasks.
- A music panel backed by Quickshell's MPRIS integration.
- A compact bottom dock with actual app launchers; optional apps appear only when installed.

The wallpaper is deliberately not replaced. AKKAD leaves your current wallpaper and wallpaper manager alone.

## Install

```bash
git clone https://github.com/Parabotx/akkad.git
cd akkad
./install.sh
```

The installer previews packages and asks before installing. Existing managed configuration folders are backed up under `~/.local/state/akkad/backups/`. It does not remove your current desktop, replace your display manager, change boot settings, or modify GPU drivers.

After installation, log out and select Hyprland. The AKKAD Quickshell interface starts with the Hyprland session. It is launched by an explicit config path, so an existing default Quickshell shell can remain in place.

## Commands

| Command | Action |
| --- | --- |
| `akkad -h` | Help |
| `akkad -u` | Update repository and sync configuration |
| `akkad -d` | Diagnostics |
| `akkad -s` | Start the shell now |
| `akkad -r` | Restart the shell |
| `akkad -x` | Stop it for this session |
| `akkad --disable-shell` | Stop and disable future autostart |
| `akkad --enable-shell` | Re-enable autostart and start it |

Hyprland shortcuts: `Super + Return` terminal, `Super + Space` launcher, `Super + Escape` lock, `Super + Alt + R` restart AKKAD shell, and `Super + 1…5` change workspace.

## Data and configuration

- Quickshell configuration: `~/.config/quickshell/akkad/`
- Persistent tasks: `~/.local/share/akkad-shell/tasks.json`
- Linux telemetry helper: `~/.config/quickshell/akkad/scripts/akkad-stats`
- Hyprland configuration: `~/.config/hypr/hyprland.lua`
- Installer backups: `~/.local/state/akkad/backups/`
- Update backups: `~/.local/state/akkad/update-backups/`

Task records are stored separately from the Git checkout and survive AKKAD updates.

## Repository layout

- `config/hypr/` — Hyprland Lua configuration.
- `config/quickshell/akkad/` — Quickshell entry point and reusable QML components.
- `config/foot/`, `config/fuzzel/`, `config/mako/` — terminal, launcher and notifications.
- `config/hyprlock/`, `config/hypr/` — lock and idle behavior.
- `config/waybar/` — optional fallback panel, not started by default.
- `packages/` — base package list.
- `scripts/` — installation, update, shell control and telemetry.
- `docs/` — design, installation and recovery notes.

## Safety and current limits

- No wallpaper is downloaded or overwritten.
- CPU, RAM, disk and network values are read from the local Linux system; unavailable sensor values show as unavailable.
- Music controls depend on a media application exposing MPRIS and on the player supporting the requested operation.
- VS Code and Discord dock icons are conditional on installed desktop entries.
- Initial widget placement is tuned for a 1920×1080 single-screen laptop; multi-monitor layout and actual performance still need testing on the target machine.

See [docs/SHELL.md](docs/SHELL.md), [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/INSTALL.md](docs/INSTALL.md) and [docs/RECOVERY.md](docs/RECOVERY.md).
