{
  pkgs,
  config,
  lib,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = ["nvidia_drm.fbdev=1"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        default = 2;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };
    plymouth = {
      enable = true;
      themePackages = [pkgs.adi1090x-plymouth-themes];
      theme = "liquid";
    };
  };
}
