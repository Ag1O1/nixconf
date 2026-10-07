let
  mkSystem = import ../../lib/mkSystem.nix;
in
  mkSystem {
    tags = ["betelgeuse" "core" "graphical" "nvidia"];
    system = "x86_64-linux";
    extraModules = [
      ../../users/amr.nix
      ./hardware.nix
      ./machine.nix
      ./packages.nix
    ];
  }
