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
    runlevels = "2345";
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
