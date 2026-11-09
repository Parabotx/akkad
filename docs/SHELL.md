# AKKAD shell guide

## Layout

- Top center: miniature Hyprland workspace dots, app icons and geometric seal.
- Upper center: live system clock, date and a clearly marked original AKKAD maxim.
- Left: CPU, RAM, root storage, thermal sensor when exposed and network throughput.
- Right: persistent task ledger and monthly calendar.
- Center: media session card controlled through MPRIS.
- Bottom center: application dock.

The current arrangement is tuned around a 1920×1080 single-monitor screen. It does not change your wallpaper.

## Tasks

Use the task ledger panel. Add a title and optionally a due value in this format:

```text
2026-11-12T18:30
```

The local task file is `~/.local/share/akkad-shell/tasks.json`. Task records are not stored in the Git repository and are not overwritten by `akkad -u`.

- Circle: mark pending/completed.
- Pencil: edit the title.
- ×: delete the task.
- DONE counter: switch between pending and completed records.
- Due dates: upcoming section and calendar dots are derived from the task records.

## Media

The player selects an active MPRIS session when one is available. Previous, play/pause, next, shuffle and repeat are enabled only when the current player reports support. Album art appears only when the player provides an artwork URL. An idle state is shown when no media session is available.

## Monitoring

Telemetry is read from local kernel interfaces. CPU and network throughput are sampled every 3.5 seconds. RAM is read from `/proc/meminfo`, storage from `df`, and temperature from readable thermal-zone files. Some machines expose no usable temperature zone; in that case the widget says it is unavailable.

## Apps

Core dock commands are installed by the AKKAD package profile. Code editor and Discord icons are conditional on matching desktop entries, so absent applications do not produce fake launch controls. The icons come from the active system icon theme.

## Control the shell

```bash
akkad -s                # Start
akkad -r                # Restart
akkad -x                # Stop for this session
akkad --disable-shell   # Disable on future Hyprland logins
akkad --enable-shell    # Re-enable and start
akkad -d                # Diagnostics
```

To edit the shell, modify QML under `~/.config/quickshell/akkad/` or the repository's `config/quickshell/akkad/`, then restart with `akkad -r`. The Quickshell file watcher may also hot-reload changes.

## Known scope limits

The current implementation does not generate or install a wallpaper, inspect your installed third-party apps remotely, or claim hardware test results. Multi-monitor placement, thermal sensor compatibility and actual performance must be confirmed on the target machine.
