{
  flake.modules.nixos.direnv = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
