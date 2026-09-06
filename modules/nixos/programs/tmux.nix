{
  flake.modules.nixos.tmux = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 0;
      shortcut = "Space";
      keyMode = "vi";
      plugins = [pkgs.tmuxPlugins.resurrect];

      extraConfig = ''
        bind -n M-j previous-window
        bind -n M-k next-window
      '';
    };
  };
}
