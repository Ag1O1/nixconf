{...}: {
  flake.nixosModules.niri = {...}: {
    programs.niri.enable = true;
  };
}
