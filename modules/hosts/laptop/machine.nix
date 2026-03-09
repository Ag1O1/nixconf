{ inputs, self, ... }: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.testModule
    ];
  };
  flake.nixosModules.testModule = {
    system.stateVersion = "24.11";
  };
}
