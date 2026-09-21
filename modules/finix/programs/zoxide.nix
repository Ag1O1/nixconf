{
  pkgs,
  lib,
  ...
}: {
  hj = {
    packages = [pkgs.zoxide];
    xdg.config.files."fish/conf.d/zoxide.fish".text = ''
      ${lib.getExe pkgs.zoxide} init fish | source
    '';
  };
}
