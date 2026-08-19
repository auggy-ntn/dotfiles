-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Personal overrides, loaded after Omarchy's defaults.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- GPU setup: this is an Optimus laptop. The eDP panel is wired to the Intel
-- iGPU (card2) and the RTX 4070 has no connected output, so aquamarine already
-- picks the iGPU as primary and composites there. The usual "NVIDIA env block"
-- (GBM_BACKEND=nvidia-drm, __GLX_VENDOR_LIBRARY_NAME=nvidia,
-- LIBVA_DRIVER_NAME=nvidia) is for NVIDIA-primary machines and only forced
-- every desktop app onto the wrong driver, keeping the dGPU awake. Games go to
-- the dGPU explicitly with `prime-run` / Steam launch options instead.
--
-- NOTE 2026-08-05: an attempt to render on the iGPU only, via
--   AQ_DRM_DEVICES=/dev/dri/by-path/pci-0000:00:02.0-card
-- made Hyprland die at startup with "CBackend::create() failed!", which left
-- SDDM falling back to the greeter. The device path itself was valid, so the
-- most likely cause is that setting it from this config is too late for
-- aquamarine, which reads AQ_DRM_DEVICES from the process environment during
-- backend init. Unverified. If retried, export it before Hyprland starts
-- (~/.config/uwsm/env) and test from a TTY first, with a way back in already
-- in place.

-- Omarchy's steam defaults float the main Steam window at a fixed 1100x700,
-- which leaves it small on this panel. Tile it instead; the Friends List and
-- the other small steam windows keep the upstream floating behaviour.
o.window({ class = "^steam$", title = "^Steam$" }, { float = false })

-- Let these games scan out directly (see allow_tearing in looknfeel.lua).
o.window({ class = "Minecraft\\* 1\\.21\\.1" }, { immediate = true })

-- CS2 runs under Xwayland as "cs2".
o.window({ class = "^cs2$" }, { immediate = true })
