{
  lib,
  config,
  ...
}:
with lib; {
  flake.modules.nixos.nvidia = {
    services.xserver.videoDrivers = ["nvidia"];
    hardware = {
      graphics.enable = true;
      nvidia = {
        enable = true;
        modesetting.enable = true;
        open = mkDefault true;
        powerManagement.finegrained = mkDefault false;
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
      };
    };
  };
}
