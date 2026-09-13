{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    pkgs.asusctl
  ];
  services.dbus.packages = [pkgs.asusctl];
  finit.services.asusd = {
    description = "asusd";
    runlevels = "S";
    command = "${lib.getExe' pkgs.asusctl "asusd"}";
  };
  custom.persist = {
    files = [
      "/etc/supergfxd.conf"
    ];
    directories = [
      "/etc/asusd"
    ];
  };
}
