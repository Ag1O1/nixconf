{pkgs, ...}: {
  flake.modules.nixos.printing = {
    services.printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.hplipWithPlugin];
    };
  };
}
