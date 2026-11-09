# Installation notes

## Supported target

AKKAD is built for Arch Linux and Arch-based distributions using pacman. It uses the stable Hyprland package from the configured repositories and targets Hyprland 0.55+ with Lua configuration.

The upstream Hyprland project recommends using distribution packages rather than mixing manually compiled or `-git` builds with repository packages.

## What the installer changes

- Installs the packages listed in `packages/base.txt` after confirmation.
- Copies AKKAD application configuration into `~/.config`.
- Backs up existing target directories under `~/.local/state/akkad/backups/`.
- Keeps a managed checkout at `~/.local/share/akkad`.
- Installs the `akkad`, `akkad-update`, and `akkad-doctor` commands into `~/.local/bin`.

## What it deliberately does not change

- Display manager, auto-login, bootloader, kernel, or initramfs.
- GPU drivers or kernel parameters.
- NetworkManager / systemd-networkd service enablement.
- Existing desktop environments or their packages.
- Existing user data outside the target configuration directories.

## Network and portals

The NetworkManager applet depends on NetworkManager. If you already use another network manager, do not enable NetworkManager blindly. Keep the network stack you already use.

The XDG portal packages provide file-picker and screen-sharing integration. Applications may request the portal backend after the first login.

## Session startup

Select the Hyprland session from your display manager. For a TTY session, use:

```bash
start-hyprland
```

Do not put this command in `.bashrc`; it belongs in a login-session workflow only.
