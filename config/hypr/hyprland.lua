-- AKKAD / Hyprland Lua configuration
-- Target: Hyprland 0.55+. Uses the native Lua API introduced in 0.55.

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
        },
    },
    general = {
        gaps_in = 5,
        gaps_out = 12,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = true,
        allow_tearing = false,
        col = {
            active_border = {
                colors = { "rgba(c99a50ff)", "rgba(382619ff)" },
                angle = 45,
            },
            inactive_border = "rgba(74604a88)",
        },
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 0.97,
        inactive_opacity = 0.93,
        shadow = {
            enabled = true,
            range = 16,
            render_power = 3,
            color = 0xee090909,
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            vibrancy = 0.04,
        },
    },
    animations = { enabled = true },
    dwindle = { pseudotile = true, preserve_split = true },
    master = { new_status = "master" },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
    cursor = { hide_on_key_press = true },
})

hl.curve("akkad-smooth", {
    type = "bezier",
    points = { { 0.22, 1.0 }, { 0.36, 1.0 } },
})
hl.curve("akkad-soft", {
    type = "bezier",
    points = { { 0.16, 1.0 }, { 0.30, 1.0 } },
})
hl.animation({ leaf = "global", enabled = true, speed = 8, bezier = "akkad-smooth" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "akkad-smooth", style = "popin 92%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "akkad-soft", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "akkad-soft", style = "popin 92%" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "akkad-soft" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "akkad-smooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "akkad-smooth", style = "slidefade 12%" })

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("NIXOS_OZONE_WL", "1")

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.float())
hl.bind(mod .. " + V", hl.dsp.window.fullscreen())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + TAB", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mod .. " + SHIFT + R", hl.dsp.reload_config())
hl.bind(mod .. " + ALT + R", hl.dsp.exec_cmd("akkad-shell restart"))

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

for i = 1, 5 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

-- Quickshell owns the compact AKKAD interface. Waybar remains installed as
-- an optional fallback but is not started, avoiding two competing panels.
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/akkad-shell autostart")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("udiskie --tray")
end)
