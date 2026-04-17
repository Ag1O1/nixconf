{
  flake.nixos.modules = {
    programes.tmux = {
      enable = true;
      baseIndex = 1;
    };
  };
}
