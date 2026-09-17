{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) str port;
  cfg = config.custom.nix-serve;
in {
  options.custom.nix-serve = {
    host = mkOption {
      type = str;
      default = "0.0.0.0";
    };
    port = mkOption {
      type = port;
      default = 5000;
    };
  };
  config = {
    finit.services.nix-serve = {
      description = "nix-serve";
      command = "${lib.getExe pkgs.nix-serve-ng} --host ${cfg.host} --port ${toString cfg.port}";
      environment = {
        NIX_SECRET_KEY_FILE = "/etc/nix/cache-private-key.pem";
      };
    };
    providers.firewall.allowedTCPPorts = [cfg.port];
    custom.persist.files = [
      "/etc/nix/cache-private-key.pem"
      "/etc/nix/cache-public-key.pem"
    ];
  };
}
