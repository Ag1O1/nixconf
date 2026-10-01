{
  tags = ["graphical"];
  module = {
    pkgs,
    lib,
    ...
  }: let
    package = pkgs.evolutionWithPlugins;
  in {
    environment.systemPackages = [package];
    services.dbus.packages = [package];

    finit.services.evolution = {
      description = "Evolution service";
      runlevels = "2345";
      command = "${lib.getExe' package "evolution"}";
    };
  };
}
