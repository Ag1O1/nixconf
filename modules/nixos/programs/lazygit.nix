{
  flake.modules.nixos.lazygit = {
    programs.lazygit = {
      enable = true;
      settings = {
        autoFetch = true;
      };
    };
  };
}
