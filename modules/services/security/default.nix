{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.services.security;
in
{
  options.modules.services.security = {
    enable = lib.mkEnableOption "Security";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [

    ];
    networking.wireless.extraConfig = ''
      openssl_ciphers=DEFAULT@SECLEVEL=0
    '';
    networking.nftables.enable = true;
    services = {
      clamav = {
        daemon.enable = true;
        updater.enable = true;
        scanner.enable = true;
      };
      fail2ban.enable = true;
    };
  };
}
