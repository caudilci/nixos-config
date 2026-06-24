{ inputs, config, pkgs, ... }: {

  imports = [
    inputs.mangowm.nixosModules.mango
  ];
  
  programs.mango.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    
    # Import Mango's HM module into your user configuration
    sharedModules = [ 
      inputs.mangowm.hmModules.mango
    ];
  };

  # Input Method (Fcitx5)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true;
      addons = with pkgs; [ qt6Packages.fcitx5-chinese-addons fcitx5-mozc fcitx5-rime rime-data ];
    };
  };

  environment.systemPackages = with pkgs; [
    kitty fuzzel yazi micro vscode git gh librewolf firefox vesktop
    starship expressvpn keepassxc steam prismlauncher heroic
    obs-studio godot freecad kicad xwayland-satellite greetd
    mako xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring
    wlr-randr tuigreet rofi lutris thunar unzip quickshell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "mango";
        user = "cc"; # auto-login on first start, no password required
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd mango";
        user = "greeter";
      };
    };
  };

}
