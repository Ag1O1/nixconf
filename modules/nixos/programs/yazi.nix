{pkgs, ...}: {
  flake.nixosModules.laptopModule = {...}: {
    programs.yazi = {
      enable = true;
      plugins = with pkgs.yaziPlugins; [
        mount
        compress
      ];
    };
  };
}
