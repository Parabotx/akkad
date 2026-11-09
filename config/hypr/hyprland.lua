-- AKKAD / Hyprland Lua configuration
-- Target: Hyprland 0.55+. Keep this file intentionally readable.

local mod = "SUPER"
local terminal = "foot"
local launcher = "fuzzel"

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            drag_lock = true,
        },
    },

    general = {
        gaps_in = 5,
        gaps_out = 12,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = true,
        allow_tearing = false,
        "col.active_border" = "rgba(c9a66bff)",
        "col.inactive_border" = "rgba(55515a88)",
    },

    decoration = {
        rounding = 12,
        active_opacity = 0.97,
        inactive_opacity = 0.93,
        shadow = {
            enabled = true,
            range = 18,
            render_power = 3,
            color = "rgba(08090fee)",
        },
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            xray = false,
            noise = 0.02,
            contrast = 0.92,
            brightness = 0.82,
        },
    },

    animations = {
        enabled = true,
        bezier = {
            "akkad-smooth", 0.22, 1, 0.36, 1,
            "akkad-soft", 0.16, 1, 0.3, 1,
        },
        animation = {
            "windows", 1, 5, "akkad-smooth",
            "windowsIn", 1, 4, "akkad-soft", "popin",
            "windowsOut", 1, 3, "akkad-soft", "popin",
            "border", 1, 6, "akkad-smooth",
            "fade", 1, 4, "akkad-soft",
            "workspaces", 1, 5, "akkad-smooth",
        },
    },

    dwindle = {
        pseudotile = true,
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        vrr = 0,
    },

    cursor = {
        hide_on_key_press = true,
    },
})

-- Environment for native Wayland applications.
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("NIXOS_OZONE_WL", "1")

-- Core applications.
hl.bind(mod .. " + RETURN", function() hl.exec_cmd(terminal) end)
hl.bind(mod .. " + SPACE", function() hl.exec_cmd(launcher) end)
hl.bind(mod .. " + E", function() hl.exec_cmd("thunar") end)
hl.bind(mod .. " + B", function() hl.exec_cmd("firefox") end)
hl.bind(mod .. " + L", function() hl.exec_cmd("hyprlock") end)
hl.bind(mod .. " + Q", hl.dsp.window.kill())
hl.bind(mod .. " + F", hl.dsp.window.float())
hl.bind(mod .. " + V", hl.dsp.window.fullscreen())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout(" togglesplit"))
hl.bind(mod .. " + SHIFT + E", function() hl.dispatch(hl.dsp.exit()) end)
hl.bind(mod .. " + SHIFT + R", function() hl.exec_cmd("hyprctl reload") end)

-- Focus and move windows using Vim-style keys.
hl.bind(mod .. " + H", hl.dsp.window.focus("l"))
hl.bind(mod .. " + L", hl.dsp.window.focus("r"))
hl.bind(mod .. " + K", hl.dsp.window.focus("u"))
hl.bind(mod .. " + J", hl.dsp.window.focus("d"))
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move("l"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move("r"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move("u"))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move("d"))

-- Workspaces 1–5.
for i = 1, 5 do
    hl.bind(mod .. " + " .. i, function()
        hl.dispatch(hl.dsp.workspace(tostring(i)))
    end)
    hl.bind(mod .. " + SHIFT + " .. i, function()
        hl.dispatch(hl.dsp.window.move_to_workspace(tostring(i)))
    end)
end

-- Audio and brightness keys.
hl.bind("XF86AudioRaiseVolume", function() hl.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+") end)
hl.bind("XF86AudioLowerVolume", function() hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end)
hl.bind("XF86AudioMute", function() hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end)
hl.bind("XF86AudioPlay", function() hl.exec_cmd("playerctl play-pause") end)
hl.bind("XF86AudioNext", function() hl.exec_cmd("playerctl next") end)
hl.bind("XF86AudioPrev", function() hl.exec_cmd("playerctl previous") end)
hl.bind("XF86MonBrightnessUp", function() hl.exec_cmd("brightnessctl set +5%") end)
hl.bind("XF86MonBrightnessDown", function() hl.exec_cmd("brightnessctl set 5%-") end)

-- Startup services. Missing optional commands do not prevent the compositor
-- from starting; each component can be replaced independently later.
hl.exec_cmd("mako")
hl.exec_cmd("hyprpaper")
hl.exec_cmd("waybar")
hl.exec_cmd("nm-applet --indicator")
hl.exec_cmd("udiskie --tray")
