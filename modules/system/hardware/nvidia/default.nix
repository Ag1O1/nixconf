{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.nvidia;
in {
  options.modules.system.hardware.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };
  config = lib.mkIf cfg.enable {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];

    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = mkMerge [
        {
          LIBVA_DRIVER_NAME = "nvidia";
          GSK_RENDERER = "ngl";
          #WLR_NO_HARDWARE_CURSORS = "1";
          #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
          #GBM_BACKEND = "nvidia-drm";
        }
      ];
      systemPackages = with pkgs; [
        #nvtopPackages.nvidia # no idea what this is but it fails to build

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

    hardware = {
      nvidia-container-toolkit.enable = true;
      nvidia = {
        #package = mkDefault config.boot.kernelPackages.nvidiaPackages.stable;
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
        /*
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "575.64.05";
          sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
          openSha256 = "sha256-mcbMVEyRxNyRrohgwWNylu45vIqF+flKHnmt47R//KU=";
          usePersistenced = false;
          useSettings = false;
        };
        */
        modesetting.enable = mkDefault true;

        powerManagement = {
          enable = mkDefault false;
          finegrained = mkDefault false;
        };

        open = mkDefault false;
        nvidiaSettings = mkDefault false; # add nvidia-settings to pkgs, useless on nixos
        nvidiaPersistenced = mkDefault false;
        forceFullCompositionPipeline = mkDefault false;
      };

      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
