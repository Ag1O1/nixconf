{
  pkgs,
  config,
  lib,
  ...
}: {
  boot = {
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    #kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelPackages = pkgs.linuxPackages_cachyos-rc;
    kernelParams = [
      "sysrq_always_enabled=0"
      "ftrace_enabled=0"
    ];
    systemd.services.wpa_supplicant.serviceConfig.TimeoutSec = "10";
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      # system fails to boot via limine
      /*
      limine = {
        enable = true;
        efiSupport = true;
        extraConfig = "default_entry=2";
        style = {
          #branding = "";
        };
        };
      */

      grub = {
        enable = true;
        default = 0;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };
    plymouth = {
      enable = true;
      themePackages = [pkgs.adi1090x-plymouth-themes];
      theme = "angular_alt";
    };
  };
}
