-- Personal input overrides.

hl.config({
  input = {
    -- Omarchy now derives kb_layout from /etc/vconsole.conf, but pin it so the
    -- layout does not depend on the console keymap staying correct.
    kb_layout = "fr",
    kb_options = "grp:shift_caps_toggle",

    repeat_rate = 40,
    repeat_delay = 600,

    numlock_by_default = true,

    sensitivity = 0,

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,

      -- Right-click is the bottom-right corner, not a two-finger click.
      clickfinger_behavior = false,
    },
  },
})

-- Per-device overrides. Names come from `hyprctl devices`.
hl.device({ name = "hp-2.4g-wireless-and-bt-mouse", sensitivity = -1 })

-- Three-finger horizontal swipe changes workspace.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
