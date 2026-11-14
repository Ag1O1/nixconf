{
  tags = ["asus"];
  module = {
    pkgs,
    lib,
    ...
  }: let
    package = pkgs.asusctl;
  in {
    environment.systemPackages = [
      package
    ];
    services.dbus.packages = [package];
    finit.services.asusd = {
      description = "asusd";
      runlevels = "2345";
      command = "${lib.getExe' package "asusd"}";
    };
    custom.persist = {
      files = [
        "/etc/supergfxd.conf"
      ];
      directories = [
        "/etc/asusd"
      ];
    };
  };
}
