{...}: {
  flake.modules.nixos.nvidia = {
    config,
    lib,
    ...
  }:
    with lib; {
      hardware = {
        graphics.enable = true;
        nvidia = {
          enable = true; # required — no equivalent to services.xserver.videoDrivers gating this
          modesetting.enable = true;
          kernelModule = mkDefault "open";
          power.runtime.enable = mkDefault false; # renamed from powerManagement.finegrained
          package = mkDefault config.boot.kernelPackages.nvidiaPackages.bleeding_edge;
        };
      };
    };
}
