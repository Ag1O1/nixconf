{...}: {
  flake.nixosModules.testModule = {
    programs.firefox.enable = true;
  };
}
