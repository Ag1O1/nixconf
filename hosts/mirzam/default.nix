let
  mkSystem = import ../../lib/mkSystem.nix;
in
  mkSystem {
    tags = ["mirzam" "core" "server"];
    system = "x86_64-linux";
    extraModules = [
      #./hardware.nix
      ./machine.nix
      ./disko.nix
      ./packages.nix
    ];
  }
