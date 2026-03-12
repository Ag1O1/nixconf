{ inputs, self, ... }: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.core
      self.nixosModules.laptopModule
      self.nixosModules.testModule
      self.nixosModules.niri

    ];
  };
  flake.nixosModules.laptopModule = { pkgs, ... }: {
    system.stateVersion = "25.11";
    environment.systemPackages = with pkgs; [
      godot
      equibop
    ];
  };
}
