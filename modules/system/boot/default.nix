{
  pkgs,
  config,
  lib,
  ...
}:
{
  boot = {
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelPackages =
      let
        apply = _: prevModules: {
          v4l2loopback =
            if lib.strings.hasPrefix "0.13.2" prevModules.v4l2loopback.version then
              prevModules.v4l2loopback.overrideAttrs (_: rec {
                version = "0.15.0";
                src = pkgs.fetchFromGitHub {
                  owner = "umlaeute";
                  repo = "v4l2loopback";
                  rev = "v${version}";
                  hash = "sha256-fa3f8GDoQTkPppAysrkA7kHuU5z2P2pqI8dKhuKYh04=";
                };
              })
            else
              prevModules.v4l2loopback;
        };
      in
      pkgs.linuxPackages_cachyos-lto.extend apply;
    #kernelPackages = pkgs.linux_cachyos;
    kernelParams = [
      "nopvspin"
      "skew_tick=1"
      "rcupdate.rcu_expedited=1"
      "tsc=nowatchdog"
      "kvm-amd.nested=0"
      "kvm-amd.npt=1"
      "kvm-amd.avic=1"
      "sysrq_always_enabled=0"
      "ftrace_enabled=0"
    ];
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
