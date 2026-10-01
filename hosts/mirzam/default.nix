let
  mkSystem = import ../../lib/mkSystem.nix;
in
  mkSystem {
    tags = ["mirzam" "server"];
    system = "x86_64-linux";
    extraModules = m: [
      ./hardware.nix
      ./machine.nix
      ./packages.nix

      # Services
      m.services.ssh
    ];
  }
