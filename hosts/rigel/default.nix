let
  mkSystem = import ../../lib/mkSystem.nix;
in
  mkSystem {
    tags = ["rigel" "core" "graphical" "asus" "nvidia" "laptop"];
    system = "x86_64-linux";
    extraModules = [
      ./hardware.nix
      ./kernel.nix
      ./machine.nix
      ./packages.nix
    ];
  }
