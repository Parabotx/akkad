# AKKAD

**An abstract, historically rooted Arch Linux desktop environment built on Hyprland.**

AKKAD is a new desktop project, not a replacement or fork of A16EEN. It is designed as a modular, keyboard-first environment with a distinctive visual language inspired by the earliest cities, writing systems, architecture, and material culture of ancient Mesopotamia.

> Foundation first. Every subsystem should be replaceable, recoverable, and documented.

## Status

<sub>Early foundation — expect active development and breaking changes.</sub>

The initial foundation provides:
- A modern Hyprland Lua configuration (Hyprland 0.55+).
- A conservative Arch Linux installer with backups and explicit confirmation.
- Essential terminal, launcher, notifications, wallpaper, lock and idle tools.
- A modular configuration layout and a simple update command.
- Safe defaults: no display-manager replacement, no automatic login, no destructive cleanup.

## Install

Clone the repository and run:

```bash
git clone https://github.com/Parabotx/akkad.git
cd akkad
./install.sh
```

The installer previews packages, asks before installing, backs up existing AKKAD-managed target files, and installs user configuration. It does not remove your current desktop environment.

Log out and select **Hyprland** from your display manager, or start it from a TTY with `start-hyprland`.

## First shortcuts

| Shortcut | Action |
| --- | --- |
| `Super + Return` | Terminal |
| `Super + Space` | Application launcher |
| `Super + Q` | Close focused window |
| `Super + F` | Toggle floating |
| `Super + 1…5` | Switch workspace |
| `Super + Shift + 1…5` | Move window to workspace |
| `Super + H/J/K/L` | Focus direction |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + Escape` | Lock screen |
| `Super + Shift + E` | Exit Hyprland |

## Repository layout

- `config/hypr/` — Hyprland Lua configuration.
- `config/foot/` — terminal configuration.
- `config/fuzzel/` — application launcher.
- `config/mako/` — notification daemon.
- `config/hyprlock/` — lock screen.
- `config/hypridle/` — idle and screen-power behavior.
- `config/waybar/` — temporary status bar foundation.
- `packages/` — curated package lists.
- `scripts/` — maintenance helpers.
- `docs/` — design and development notes.

## Principles

1. **Independent:** AKKAD never assumes A16EEN or Niri is installed.
2. **Modular:** each component has a clear boundary and can be replaced.
3. **Recoverable:** installers back up files and never overwrite silently.
4. **Native first:** prefer Arch repository packages over fragile -git builds.
5. **Accessible:** keyboard navigation, readable contrast, and reduced-motion options.
6. **Distinctive:** abstract, restrained, architectural — not a generic neon gaming rice.

## Important

Hyprland's configuration changed to Lua in version 0.55. AKKAD targets the current Lua configuration model. The installer checks for the required tools but does not attempt to modify system boot, login, GPU drivers, or display-manager configuration.

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) and [docs/ROADMAP.md](docs/ROADMAP.md).
