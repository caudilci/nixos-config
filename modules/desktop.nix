{ config, pkgs, ... }: {
  imports = [ ./niri-config.nix ];

  programs.niri.enable = true;

  # REMOVED: All programs.dms-shell and services.displayManager.dms-greeter blocks

  # ADDED: Noctalia v5 Configuration
  programs.noctalia = {
    enable = true;
    # You can add specific noctalia options here if needed,
    # but .enable is the primary switch for the NixOS module.
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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
}
