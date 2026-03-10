{...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri.enable = true;
  };
}
