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
      // Core Noctalia binds
      Mod+Space { spawn-sh "qs -c noctalia-shell ipc call launcher toggle"; }
      Mod+S { spawn-sh "qs -c noctalia-shell ipc call controlCenter toggle"; }
      Mod+Comma { spawn-sh "qs -c noctalia-shell ipc call settings toggle"; }
  
      // Audio & Brightness
      XF86AudioRaiseVolume { spawn "qs" "-c" "noctalia-shell" "ipc" "call" "volume" "increase"; }
      XF86AudioLowerVolume { spawn "qs" "-c" "noctalia-shell" "ipc" "call" "volume" "decrease"; }
      XF86AudioMute { spawn "qs" "-c" "noctalia-shell" "ipc" "call" "volume" "muteOutput"; }
      XF86MonBrightnessUp { spawn "qs" "-c" "noctalia-shell" "ipc" "call" "brightness" "increase"; }
      XF86MonBrightnessDown { spawn "qs" "-c" "noctalia-shell" "ipc" "call" "brightness" "decrease"; }
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
