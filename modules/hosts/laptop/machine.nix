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
    ];
  };
  flake.nixosModules.laptopModule = {...}: {
    programs.yazi.enable = true;
  };

  flake.nixosModules.laptopHardware = {
    system.stateVersion = "25.11";
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
