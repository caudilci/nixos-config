{ config, pkgs, ... }: {
  # --- System Basics ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 11434 ];
  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --- User Identity ---
  users.users.cc = {
    isNormalUser = true;
    description = "cc";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
  };

  # --- Graphical Login (Greetd + QtGreetD) ---
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # This launches the qtgreetd binary
        cmd = "${pkgs.qtgreetd}/bin/qtgreetd";
        user = "greeter";
      };
    };
  };

  # QtGreetD requires a configuration file to know what to launch after login
  environment.etc."qtgreetd".text = ''
    # This tells the greeter to start Niri with a DBus session
    # so that Noctalia and other apps work correctly.
    command = "dbus-run-session niri"
  '';

  # --- System Services & Permissions ---
  virtualisation.docker.enable = true;
  nixpkgs.config.allowUnfree = true;
}
