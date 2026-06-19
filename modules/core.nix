{ config, pkgs, ... }: {
  # --- System Basics ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables = {
  };

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

  # --- System Services & Permissions ---
  virtualisation.docker.enable = true;
  nixpkgs.config.allowUnfree = true;

  hardware.firmware = [
    (pkgs.runCommandNoCC "custom-edid" {} ''
      mkdir -p $out/lib/firmware/edid
      cp ${./monitor_edid_edited.bin} $out/lib/firmware/edid/monitor_edid_edited.bin
    '')
  ];

  boot.kernelParams = [ "video=DP-1:5120x1440@240" "drm.edid_firmware=edid/monitor_edid_edited.bin" ];
}
