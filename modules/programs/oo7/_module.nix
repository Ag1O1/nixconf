{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.oo7;
in {
  options.programs.oo7.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Whether to enable [oo7](${pkgs.oo7.meta.homepage}).
    '';
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.oo7];

    services.dbus.packages = [
      (pkgs.writeTextDir "share/dbus-1/services/org.freedesktop.secrets.service" ''
        [D-BUS Service]
        Name=org.freedesktop.secrets
        Exec=${config.security.wrapperDir}/oo7-daemon
      '')
    ];

    xdg.portal.portals = [pkgs.oo7-portal pkgs.gcr_3];

    security.wrappers.oo7-daemon = {
      owner = "root";
      group = "root";
      capabilities = "cap_ipc_lock=ep";
      source = "${pkgs.oo7-server}/libexec/oo7-daemon";
    };
  };
}
