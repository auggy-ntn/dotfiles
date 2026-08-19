-- Extra autostart processes.

-- Set cursor theme.
o.exec_on_start("hyprctl setcursor Bibata-Modern-Classic 22")

-- Start pCloud drive.
-- Delayed so the Electron startup does not compete with compositor init - that
-- burst is what pushes the chassis to ~69C at login and makes the fan ramp.
-- ~/pCloudDrive is unavailable for the first 20s after login as a result.
--
-- This is the ONLY pCloud autostart. The XDG entry (~/.config/autostart/
-- pcloud.desktop) launched a second AppImage that burned ~950ms CPU and 185MB
-- before exiting on the single-instance lock; its unit is masked with
--   systemctl --user mask app-pcloud@autostart.service
-- Masking is used rather than editing the .desktop because pCloud regenerates
-- its own launcher files. Undo with `systemctl --user unmask`.
o.exec_on_start("sleep 20 && pcloud --disable-gpu")

-- pCloud has no "start minimized" option - no CLI flag, nothing in its
-- config.json - so it always pops its window open on launch. Closing that window
-- leaves the app running in the tray and keeps ~/pCloudDrive mounted (verified),
-- which is exactly what happens when you close it by hand.
--
-- Polls for the window instead of using a fixed delay, so a slow start still
-- works. Gives up after 60s. Deliberately NOT a windowrule: a persistent
-- `workspace special silent` rule would also swallow the window when YOU open
-- pCloud from the tray, which is worse than the problem being solved.
o.exec_on_start([[bash -c 'for i in $(seq 1 60); do sleep 1; if hyprctl clients -j | grep -q "\"class\": \"pcloud\""; then sleep 1; hyprctl dispatch closewindow class:pcloud; break; fi; done']])
