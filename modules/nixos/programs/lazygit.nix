{
  flake.modules.nixos.lazygit = {
    programs.lazygit = {
      enable = true;
      settings = {
        git.autoFetch = false;
      };
    };
  };
}
