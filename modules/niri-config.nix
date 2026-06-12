{ config, pkgs, ... }: {
  environment.etc."niri/config.kdl".text = ''
    // --- Modern Niri Standards & Noctalia Integration ---

    // REMOVED: include "dms-defaults.kdl" (DMS is gone)

    input {
      keyboard { xkb_layout "us" }
      touchpad { tap; natural-scroll; }
    }

    output "eDP-1" {
      mode "1920x1080"
      scale 1.0
    }

    layout {
        gaps 12
        center-gaps true
        default-column-width { proportion 0.33; }
    }

    binds {
        Mod+Return { spawn "kitty"; }
        Mod+D { spawn "fuzzel"; }
        Mod+Q { quit; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }

        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }
    }

    // ADDED: Autostart Noctalia
    // This ensures the bar starts automatically when Niri does.
    spawn "noctalia"

    window-rule {
        if app-id "pavucontrol" then { floating true; }
        if app-id "blueman-manager" then { floating true; }
    }
  '';
}
