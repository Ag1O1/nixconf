{
  #tags = ["graphical"];
  module = {pkgs, ...}: let
    package = pkgs.evolution-data-server;
  in {
    services.dbus.packages = [package];
  };
}
