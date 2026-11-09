# Recovery and troubleshooting

AKKAD is designed to coexist with an existing Arch desktop. It does not replace your display manager, bootloader, network stack, or current desktop session.

## If Hyprland does not start

1. Switch to a TTY with `Ctrl + Alt + F3` (or another available TTY).
2. Log in and inspect the session log:

   ```bash
   journalctl --user -b --no-pager | tail -n 120
   ```

3. Check the compositor version and configuration:

   ```bash
   hyprctl version
   ls -l ~/.config/hypr/hyprland.lua
   ```

4. Temporarily move the AKKAD config out of the way to let Hyprland generate its own example:

   ```bash
   mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.akkad-disabled
   ```

5. Return to the display manager or start a new session with `start-hyprland`.

This does not uninstall Hyprland or delete your settings.

## Restore backed-up configuration

Installer backups are stored under:

```text
~/.local/state/akkad/backups/
```

Update backups are stored under:

```text
~/.local/state/akkad/update-backups/
```

Choose the timestamp you want, then copy only the configuration directories you need back into `~/.config`. Do not blindly restore every directory if you have since customized other applications.

## NVIDIA systems

Hyprland's upstream documentation notes that NVIDIA systems may need additional driver-specific configuration. AKKAD deliberately does not guess GPU driver settings. Read the current [Hyprland NVIDIA guidance](https://wiki.hypr.land/Nvidia/) before changing environment variables or kernel parameters.

## Diagnostics

Run:

```bash
akkad -d
hyprctl version
hyprctl monitors
hyprctl clients
```

If the compositor is not running, `hyprctl` cannot connect; that is expected.
