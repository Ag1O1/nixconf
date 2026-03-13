{...}: {
  flake.modules.nixos.printing = {pkgs, ...}: {
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
