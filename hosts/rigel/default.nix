let
  mkSystem = import ../../lib/mkSystem.nix;
in
  mkSystem {
    tags = ["rigel" "core" "graphical" "asus" "nvidia" "virt" "gaming" "laptop" "impermanent"];
    system = "x86_64-linux";
    extraModules = [
      ../../users/amr.nix
      ./hardware.nix
      #./kernel.nix
      ./machine.nix
      ./packages.nix
    ];
  }
