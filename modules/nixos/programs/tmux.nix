{
  flake.modules.nixos.tmux = {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
    };
  };
}
