{ config, pkgs, ... }: {
  imports = [ ./hardware.nix ];

  networking.hostName = "nixos";
  time.timeZone = "America/New_York";

  # Ensure we are using the latest state version
  system.stateVersion = "26.05";
}