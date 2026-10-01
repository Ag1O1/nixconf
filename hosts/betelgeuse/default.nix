let
  mkSystem = import ../../lib/mkSystem.nix;
in
  mkSystem {
    tags = ["betelgeuse" "core" "graphical" "nvidia"];
    system = "x86_64-linux";
    extraModules = [
      ./hardware.nix
      ./machine.nix
      ./packages.nix
    ];
  }
