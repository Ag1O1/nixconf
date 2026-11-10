{
  tags = ["core"];
  module = {
    pkgs,
    lib,
    fm,
    ...
  }: {
    imports = [fm.doas];
    programs.doas.enable = true;
    environment.systemPackages = [
      (pkgs.writeScriptBin "sudo" ''
        #!/bin/sh
        exec /run/wrappers/bin/doas "$@"
      '')
    ];
    environment.etc."doas.conf".text = lib.mkAfter ''
      permit persist :wheel
    '';
  };
}
