{ config, pkgs, ... }: {
  imports = [ ./niri-config.nix ]; # <--- Add this import

  programs.niri.enable = true;

  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
    systemd.restartIfChanged = true;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

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

  # General Desktop Apps
  environment.systemPackages = with pkgs; [
    kitty fuzzel yazi micro vscode git gh librewolf firefox vesktop
    spotify expressvpn keepassxc steam prismlauncher heroic
    obs-studio godot freecad kicad xwayland-satellite
  ];

  programs.firefox.enable = true;
  programs.steam.enable = true;
  services.expressvpn.enable = true;
  programs.dsearch.enable = true;
  programs.coolercontrol.enable = true;

  # Sound (Pipewire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
}