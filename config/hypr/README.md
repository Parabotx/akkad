# Hyprland configuration

The entry point is `hyprland.lua`. This project targets Hyprland 0.55+ and uses the native Lua configuration API. Do not paste legacy `hyprland.conf` syntax into this directory.

Keep future modules small and require them from the entry point, for example:

```lua
require("akkad.appearance")
require("akkad.keybinds")
require("akkad.rules")
```

The first iteration intentionally keeps the configuration in one file so the base can be tested before splitting it into subsystems.
