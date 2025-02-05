{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.boot;
in {
  options.modules.system.boot = {
    grub = {
      enable = lib.mkEnableOption "grub" true;
      default = lib.mkDefault 0;
    };
    plymouth.enable = lib.mkEnableOption "plymouth";
  };
  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
      kernelParams = ["nvidia_drm.fbdev=1"];
      loader = {
        efi = {
          canTouchEfiVariables = true;
        };

        config = mkIf cfg.grub.enable {
          grub = {
            enable = true;
            default = "${default}";
            efiSupport = true;
            useOSProber = true;
            device = "nodev";
          };
        };
      };
      plymouth = {
        enable = true;
        themePackages = [pkgs.adi1090x-plymouth-themes];
        theme = "liquid";
      };
    };
  };
}
