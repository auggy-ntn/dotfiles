-- Personal keybinding overrides.
--
-- Ported from the pre-Quattro bindings.conf. Anything Omarchy now ships as a
-- default (terminal, browser, file manager, editor, tmux, lazydocker, ChatGPT)
-- was dropped instead of re-declared.
--
-- The French AZERTY workspace bindings are also gone on purpose: Omarchy's
-- defaults bind workspaces by physical keycode (code:10-19), so the number row
-- works on AZERTY without a layout-specific override.

-- Apps not covered by Omarchy's defaults.
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })
o.bind("SUPER + SHIFT + L", "Anytype", { launch = "anytype" })

-- Was: Music (Spotify).
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Mail", { launch = "thunderbird" })

-- Was: Omawrite.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Force kill window", hl.dsp.window.close({ force = true }))

-- Was: Toggle workspace layout (which moved to SUPER + L in Quattro).
hl.unbind("SUPER + L")
o.bind("SUPER + L", "Lock system", "omarchy-system-lock")

-- Numpad workspace switching (numlock is on by default, see input.lua).
local numpad_keys = {
  "KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin",
  "KP_Right", "KP_Home", "KP_Up", "KP_Prior", "KP_Insert",
}

for workspace, key in ipairs(numpad_keys) do
  o.bind("SUPER + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = tostring(workspace) }))
  o.bind("SUPER + SHIFT + " .. key, "Move window to workspace " .. workspace, hl.dsp.window.move({ workspace = tostring(workspace) }))
end
