{
  flake.modules.nixos.tmux = {
    programes.tmux = {
      enable = true;
      baseIndex = 1;
    };
  };
}
