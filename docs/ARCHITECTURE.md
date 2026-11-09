# AKKAD architecture

## Desktop stack

| Layer | Implementation | Responsibility |
| --- | --- | --- |
| Compositor | Hyprland 0.55+ | Windows, workspaces, input, outputs and effects |
| Desktop shell | Quickshell 0.3+ | Center navbar, clock, telemetry, task ledger, calendar, media and dock |
| Launcher | Fuzzel | Keyboard-first application search |
| Terminal | foot | Lightweight terminal |
| Notifications | mako | Notifications |
| Lock / idle | hyprlock + hypridle | Session lock and idle behavior |
| Wallpaper backend | Existing user setup | AKKAD does not replace or select a wallpaper |
| Fallback panel | Waybar | Installed but not started by default |
| Portals | XDG portal + Hyprland portal | Screen sharing and file pickers |
| Media | Quickshell MPRIS integration | Real media sessions and transport controls |

## Visual system

The interface is an abstract interpretation of ancient Mesopotamian imperial instruments: carved geometry, concentric astronomy rings, miniature seals, monumental negative space and fine bronze linework. Historical references are used as a design vocabulary rather than literal museum ornament.

### Palette

- Obsidian: `#090909`
- Deep charcoal: `#15110E`
- Dark bronze: `#382619`
- Ancient gold: `#C99A50`
- Warm amber: `#E5A34F`
- Muted sandstone: `#A98A65`
- Soft ivory: `#EAD9B7`

Gold and amber are reserved for active states, fine borders and key information. Avoid RGB effects and arbitrary accent colors.

## Quickshell components

- `shell.qml` — desktop composition and panel placement.
- `components/Palette.js` — shared colors.
- `components/ImperialPanel.qml` — shared surface and frame.
- `components/AppIconButton.qml` — theme-aware desktop-entry launcher.
- `components/ClockFace.qml` — system clock and slow orbital marker.
- `components/SystemMonitor.qml` — telemetry display with 3.5-second refresh.
- `components/TaskLedger.qml` — persistent local task CRUD.
- `components/CalendarCard.qml` — real system month with task due-date markers.
- `components/MusicCard.qml` — live MPRIS metadata, position and supported controls.
- `components/DockBar.qml` — compact bottom app dock.

## Data boundaries

- Task data is stored in Quickshell's separate data directory at `~/.local/share/akkad-shell/tasks.json`.
- System telemetry is read locally from `/proc`, `/sys`, `df` and the default route. It does not invent values or call remote services.
- Music is controlled through MPRIS. Unsupported operations are disabled by player capability flags.
- Desktop launchers use installed desktop entries where available; optional applications are hidden if no entry exists.
- Wallpaper, desktop files, network manager configuration and GPU drivers are outside the shell's write scope.

## Engineering rules

- Prefer stable Arch repository packages.
- Keep shell widgets in independent QML components.
- Keep user data separate from configuration and the Git checkout.
- Back up pre-existing configuration folders before syncing.
- Never enable a network manager or system service globally without a clear reason.
- Keep a TTY recovery path and document shell disable controls.
- Do not claim a component is tested on a user's machine until it has actually been run there.
