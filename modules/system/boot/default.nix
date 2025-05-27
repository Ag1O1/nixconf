{
  pkgs,
  config,
  lib,
  ...
}:
{
  boot = {
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    #kernelPackages = pkgs.linuxPackages_cachyos;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelParams = [ "nvidia_drm.fbdev=1" ];
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
        default = 2;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "liquid";
    };
  };
}
