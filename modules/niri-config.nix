{ config, pkgs, ... }: {
  environment.etc."niri/config.kdl".text = ''

    layout {
        // You can tailor the gaps to fit dms spacing.
        gaps 5
        background-color "transparent"
    }

    layer-rule {
        match namespace="^quickshell$"
        place-within-backdrop true
    }

    layer-rule {
        match namespace="dms:blurwallpaper"
        place-within-backdrop true
    }

    spawn-at-startup "dms" "run"

    // Optional: Clipboard history
    spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"

    environment {
      XDG_CURRENT_DESKTOP "niri"
      QT_QPA_PLATFORM "wayland"
      ELECTRON_OZONE_PLATFORM_HINT "auto"
      QT_QPA_PLATFORMTHEME "gtk3"
      QT_QPA_PLATFORMTHEME_QT6 "gtk3"
    }

    binds {
        // Application Launchers
        Mod+Space hotkey-overlay-title="Application Launcher" {
            spawn "dms" "ipc" "call" "spotlight" "toggle";
        }
        Mod+V hotkey-overlay-title="Clipboard Manager" {
            spawn "dms" "ipc" "call" "clipboard" "toggle";
        }
        Mod+M hotkey-overlay-title="Task Manager" {
            spawn "dms" "ipc" "call" "processlist" "focusOrToggle";
        }
        Mod+Comma hotkey-overlay-title="Settings" {
            spawn "dms" "ipc" "call" "settings" "focusOrToggle";
        }
        Mod+N hotkey-overlay-title="Notification Center" {
            spawn "dms" "ipc" "call" "notifications" "toggle";
        }
        Mod+Y hotkey-overlay-title="Browse Wallpapers" {
            spawn "dms" "ipc" "call" "dankdash" "wallpaper";
        }

        // Security
        Mod+Alt+L hotkey-overlay-title="Lock Screen" {
            spawn "dms" "ipc" "call" "lock" "lock";
        }

        // Audio Controls
        XF86AudioRaiseVolume allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "increment" "3";
        }
        XF86AudioLowerVolume allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "decrement" "3";
        }
        XF86AudioMute allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "mute";
        }

        // Brightness Controls
        XF86MonBrightnessUp allow-when-locked=true {
          spawn "dms" "ipc" "call" "brightness" "increment" "5" "";
        }
        XF86MonBrightnessDown allow-when-locked=true {
          spawn "dms" "ipc" "call" "brightness" "decrement" "5" "";
        }
    }

    output "Samsung Electric Company Odyssey G95SC H1AK500000" {
        mode "5120x1440@240.000"  // Set resolution and refresh rate
        scale 1              // Set HiDPI scaling
        position x=0 y=0         // Manually position the display
        transform "normal"           // Rotate screen ("normal", "90", "180", "270")
        variable-refresh-rate
    }

    include "/home/cc/.config/niri/dms/colors.kdl"
    include "/home/cc/.config/niri/dms/layout.kdl"
    include "/home/cc/.config/niri/dms/alttab.kdl"
    include "/home/cc/.config/niri/dms/binds.kdl"
  '';
}
