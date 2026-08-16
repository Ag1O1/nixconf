{
  inputs,
  self,
  ...
}: {
  # TODO cleanup this file
  flake = {
    nixosConfigurations.laptop = inputs.finix.lib.finixSystem {
      lib = inputs.nixpkgs.lib;
      system = "x86_64-linux";
      modules = with self.modules.nixos; [
        # Core
        nix
        core-packages
        laptopHardware
        laptopPackages
        laptopModule
        laptopKernel
        # User
        user-amr
        mime
        # Modules
        #sops
        nix-search-tv
        theming
        pipewire
        networking
        nvidia
        tlp
        fish
        #printing
        keyd
        #direnv
        AI

        niri
        noctalia

        yazi
        helium
        gaming
        virt-manager
        logisim
        tmux
        lazygit
        obs
      ];
    };
    modules.nixos.laptopModule = {
      lib,
      pkgs,
      ...
    }: {
      services.input-remapper.enable = true;
      hardware.uinput.enable = true;
      programs.ydotool.enable = true;
      services.ratbagd.enable = true;
      #systemd.services.systemd-machine-id-commit.enable = false;

      /*
      boot.extraModprobeConfig =
        lib.mkAfter
        ''
          options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera" max_buffers=2
        '';
      */
      environment.etc."modprobe.d/v4l2loopback.conf".text = ''
        options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera" max_buffers=2
      '';

      boot.initrd = {
        #includeDefaultModules = lib.mkForce false;
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "btrfs"
          # LUKS/crypto modules
          /*
          "dm_mod"
          "dm_crypt"
          "aesni_intel"
          "xts"
          "cryptd"
          */
        ];
      };
      #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
      #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;
      #boot.kernelPackages = pkgs.linuxPackages_latest;

      #boot.plymouth = {
      #enable = true;
      #themePackages = [pkgs.adi1090x-plymouth-themes];
      #theme = "deus_ex";
      #};

      services = {
        logind.settings.Login.HandleLidSwitch = "ignore";
        openssh.enable = true;
        flatpak.enable = true;
        displayManager.ly.enable = true;
      };
      programs = {
        #droidcam.enable = true;
        #firejail.enable = true;
        zoxide.enable = true;
        kdeconnect.enable = true;
      };
      virtualisation.waydroid.enable = true;
    };

    modules.nixos.laptopHardware = {config, ...}: {
      system.stateVersion = "25.11";
      #hardware.facter.reportPath = ./facter.json;
      time.timeZone = "Africa/Cairo";
      i18n.defaultLocale = "en_US.UTF-8";

      users.mutableUsers = false;
      users.users.root.password = "test";

      hardware.nvidia.prime = {
        amdgpuBusId = "PCI:102:0:0";
        nvidiaBusId = "PCI:01:0:0";
      };
      services.asusd.enable = true;

      boot = {
        kernelParams = [
          #"zswap.enabled=0"
          "zswap.enabled=1"
          "zswap.compressor=zstd"
          "zswap.max_pool_percent=30"
          "amdgpu.dcdebugmask=0x410"
          "amdgpu.sg_display=0"
          "nvidia.NVreg_DynamicPowerManagement=0x02"
          "nvidia.NVreg_EnableS0ixPowerManagement=1"
          "nvidia.NVreg_DynamicPowerManagementVideoMemoryThreshold=200"
        ];
        loader = {
          efi.canTouchEfiVariables = true;
        };
      };
      programs.limine = {
        enable = true;
        efiSupport = true;
      };

      ##### File system configuration #####

      services = {
        gvfs.enable = true;
        udisks2.enable = true;
        devmon.enable = true;
      };

      fileSystems = {
        /*
        "/" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
          options = [
            "subvol=@nixos"
            "compress=zstd:1"
            "noatime"
            "discard=async"
            "autodefrag"
          ];
        };
        */
        "/" = {
          device = "tmpfs";
          fsType = "tmpfs";
          options = [
            "defaults"
            "size=4G"
            "mode=755"
          ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/66E7-77B4";
          fsType = "vfat";
          options = ["fmask=0077" "dmask=0077"];
        };
        "/home" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
          options = [
            "subvol=@home"
            "compress=zstd:1"
            "noatime"
            "discard=async"
            "autodefrag"
          ];
        };
        "/persistent" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
          neededForBoot = true;
          options = [
            "subvol=@persistent"
            "compress=zstd:1"
            "noatime"
          ];
        };
        "/home/amr/drive" = {
          device = "/dev/disk/by-uuid/b75ce50d-1020-4784-824a-dae35069d641";
          fsType = "ext4";
          options = ["defaults" "noatime" "nofail"];
        };
        "/home/amr/Downloads" = {
          device = "/home/amr/drive/downloads";
          fsType = "none";
          options = ["bind"];
          depends = ["/home/amr/drive"];
        };
        "/home/amr/Games" = {
          device = "/home/amr/drive/Games";
          fsType = "none";
          options = ["bind"];
          depends = ["/home/amr/drive"];
        };
        "/mnt/swap" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
          options = [
            "subvol=@swap"
            "noatime"
          ];
        };
        "/nix" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
          options = [
            "subvol=@nix"
            "compress=zstd:1"
            "noatime"
            "discard=async"
          ];
        };
      };
      swapDevices = [
        {
          device = "/mnt/swap/swapfile";
          size = 24576; # MiB
        }
      ];
    };
  };
}
