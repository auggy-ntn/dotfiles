-- Personal display configuration.
-- List monitors and supported modes with: hyprctl monitors all

hl.env("GDK_SCALE", "2")

-- Laptop panel. It only exposes 240Hz and 60Hz -- asking for 120 silently fell
-- back to 60.
hl.monitor({ output = "eDP-2", mode = "2560x1600@240", position = "auto", scale = 1.6 })

-- External HDMI monitor, mirroring the laptop panel.
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1.6, mirror = "eDP-2" })
