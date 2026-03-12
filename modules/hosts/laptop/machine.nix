{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.core
      self.nixosModules.laptopHardware
      self.nixosModules.laptopModule
      self.nixosModules.laptopPackages
      #self.nixosModules.testModule
      self.nixosModules.niri
      self.nixosModules.pipewire
    ];
  };
  flake.nixosModules.laptopModule = {...}: {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "niri-session";
          user = "amr";
        };
        default_session = initial_session;
      };
    };
  };

  flake.nixosModules.laptopHardware = {
    system.stateVersion = "25.11";
    hardware.facter.reportPath = "./facter.json";
    users.users.test = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      initialPassword = "test";
    };
    users.users.root.initialPassword = "root";
    # Temp fake hardware for testing
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
  };
}
