{ config, pkgs, ... }: {
  imports = [ ./niri-config.nix ./dms-greeter-config.nix ];

  programs.niri.enable = true;

  # Input Method (Fcitx5)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true;
      addons = with pkgs; [ fcitx5-chewing qt6Packages.fcitx5-chinese-addons fcitx5-mozc fcitx5-rime rime-data ];
    };
  };

  environment.systemPackages = with pkgs; [
    kitty fuzzel yazi micro vscode git gh librewolf firefox vesktop
    starship expressvpn keepassxc steam prismlauncher heroic
    obs-studio godot freecad kicad xwayland-satellite greetd
  ];

  programs.firefox.enable = true;
  programs.steam.enable = true;
  services.expressvpn.enable = true;
  programs.dsearch.enable = true;
  programs.coolercontrol.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
    };
    
    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableClipboardPaste = true;       # Pasting from the clipboard history (wtype)
  };

  services = {
    desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
    displayManager.plasma-login-manager.enable = true;

  # Optionally enable xserver
  # xserver.enable = true;
  };
}
