-- Personal look'n'feel overrides.

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 5,
    border_size = 1,

    layout = "master",

    -- Required for the per-game `immediate = true` window rules in hyprland.lua.
    allow_tearing = true,
  },

  decoration = {
    rounding = 8,
  },

  -- Let fullscreen games hand their buffer straight to the display, skipping a
  -- compositing pass. https://wiki.hypr.land/Configuring/Basics/Variables/#render
  render = {
    direct_scanout = 1,
  },
})
