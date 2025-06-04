{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.system.hardware.nvidia;
in
{
  options.modules.system.hardware.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };
  config = lib.mkIf cfg.enable {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = [ "nvidia" ];
      }
    ];

    boot.blacklistedKernelModules = [ "nouveau" ];

    environment = {
      sessionVariables = mkMerge [
        {
          LIBVA_DRIVER_NAME = "nvidia";
          #WLR_NO_HARDWARE_CURSORS = "1";
          #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
          #GBM_BACKEND = "nvidia-drm";
        }
      ];
      systemPackages = with pkgs; [
        nvtopPackages.nvidia

        # mesa
        mesa

        # vulkan
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer

        # libva
        libva
        libva-utils
      ];
    };

    hardware =
      let
        # Preferred NVIDIA Version
        nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "575.57.08";
          sha256_64bit = "sha256-KqcB2sGAp7IKbleMzNkB3tjUTlfWBYDwj50o3R//xvI=";
          sha256_aarch64 = "sha256-VJ5z5PdAL2YnXuZltuOirl179XKWt0O4JNcT8gUgO98=";
          openSha256 = "sha256-DOJw73sjhQoy+5R0GHGnUddE6xaXb/z/Ihq3BKBf+lg=";
          settingsSha256 = "sha256-AIeeDXFEo9VEKCgXnY3QvrW5iWZeIVg4LBCeRtMs5Io=";
          persistencedSha256 = "sha256-Len7Va4HYp5r3wMpAhL4VsPu5S0JOshPFywbO7vYnGo=";

          patches = [ gpl_symbols_linux_615_patch ];
        };

        gpl_symbols_linux_615_patch = pkgs.fetchpatch {
          url = "https://github.com/CachyOS/kernel-patches/raw/914aea4298e3744beddad09f3d2773d71839b182/6.15/misc/nvidia/0003-Workaround-nv_vm_flags_-calling-GPL-only-code.patch";
          hash = "sha256-YOTAvONchPPSVDP9eJ9236pAPtxYK5nAePNtm2dlvb4=";
          stripLen = 1;
          extraPrefix = "kernel/";
        };
      in
      {
        nvidia = {
          #package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
          package = nvidiaPackage;
          modesetting.enable = mkDefault true;

          powerManagement = {
            enable = mkDefault true;
            finegrained = mkDefault false;
          };

          open = mkDefault false;
          nvidiaSettings = false; # add nvidia-settings to pkgs, useless on nixos
          nvidiaPersistenced = true;
          forceFullCompositionPipeline = true;
        };

        graphics = {
          extraPackages = with pkgs; [ nvidia-vaapi-driver ];
          extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
        };
      };
  };
}
