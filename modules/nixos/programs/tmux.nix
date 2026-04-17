{
  flake.nixos.modules.tmux = {
    programes.tmux = {
      enable = true;
      baseIndex = 1;
    };
  };
}
