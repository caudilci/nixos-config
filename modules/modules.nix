{ config, pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.amdgpu.overdrive.enable = true;

  # Lact for monitoring / overclocking AMD GPUs
  services.lact.enable = true;
  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}