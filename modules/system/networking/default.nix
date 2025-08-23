{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.system.networking;
in
{
  options.modules.system.networking = {
    enable = lib.mkEnableOption "networking";
  };
  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
      };
      firewall = {
        enable = true;
        #allowedTCPPorts = [];
      };
    };
  };
}
