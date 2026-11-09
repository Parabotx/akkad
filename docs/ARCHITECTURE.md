# AKKAD architecture

## Desktop stack

| Layer | Foundation | Responsibility |
| --- | --- | --- |
| Compositor | Hyprland | Windows, workspaces, input, outputs, effects |
| Shell | Quickshell (planned first-class shell) | Navbar, dashboard, quick settings, notifications UI |
| Launcher | Fuzzel | Fast keyboard-first application search |
| Terminal | foot | Lightweight terminal |
| Notifications | mako | Notification daemon |
| Lock / idle | hyprlock + hypridle | Session security and power behavior |
| Wallpaper | hyprpaper | Initial wallpaper backend |
| Status fallback | Waybar | Reliable status while the custom shell is developed |
| Portals | XDG portal + Hyprland portal | Screen sharing, file pickers, desktop integration |

## Design direction

AKKAD takes its name and conceptual inspiration from ancient Mesopotamian history. The interface should feel like a contemporary instrument shaped by archaeological forms: monumental geometry, layered surfaces, carved-line motifs, restrained earth/stone/metal colors, and purposeful negative space.

Avoid literal museum decoration, random cuneiform glyphs, excessive gold, neon gradients, and generic gaming HUD patterns. Historical inspiration is a design vocabulary, not a theme pasted over every widget.

Initial palette:
- Obsidian: `#111318`
- Basalt: `#24262d`
- Limestone: `#e8e1d5`
- Aged bronze: `#c9a66b`
- Terracotta: `#c97968`
- Muted sage: `#9eaa82`

## Engineering rules

- Prefer stable Arch repository packages.
- Keep shell widgets in independent QML components.
- Keep user settings separate from generated/cache state.
- Never run destructive cleanup in install/update scripts.
- Back up existing target config before replacement.
- Do not enable services globally unless there is a clear reason.
- Keep a fallback path to a TTY and document recovery.
- Test each subsystem independently before integrating it into the shell.

## Planned shell modules

1. Panel / navbar and workspace overview.
2. App launcher and command palette.
3. Control center: network, Bluetooth, audio, brightness, power.
4. Notification center and media controls.
5. Wallpaper and adaptive theme engine.
6. Lock screen and idle manager.
7. System monitor and update center.
8. Settings / appearance manager.
