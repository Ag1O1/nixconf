{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.modules.nixos; [
        # Core
        nix
        core-packages
        laptopHardware
        laptopPackages
        laptopModule
        #laptopKernel
        # User
        user-amr
        mime
        # Modules
        nix-search-tv
        theming
        pipewire
        networking
        nvidia
        tlp
        fish
        printing
        keyd
        direnv
        AI
        searx

        niri
        noctalia

        yazi
        firefox
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
      imports = [
        inputs.distro-grub-themes.nixosModules.x86_64-linux.default
      ];
      distro-grub-themes = {
        enable = true;
        theme = "nixos";
      };

      boot.extraModprobeConfig =
        lib.mkAfter
        ''
          options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera" max_buffers=2
        '';

      boot.initrd = {
        includeDefaultModules = lib.mkForce false;
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
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;
      #boot.kernelPackages = pkgs.linuxPackages_latest;

      services = {
        logind.settings.Login.HandleLidSwitch = "ignore";
        openssh.enable = true;
        flatpak.enable = true;
        displayManager.ly.enable = true;
      };
      programs = {
        droidcam.enable = true;
        firejail.enable = true;
        zoxide.enable = true;
        kdeconnect.enable = true;
      };
      virtualisation.waydroid.enable = true;

      environment.shellAliases = {
        os-rebuild = "nh os switch /home/amr/nixos -H laptop";
        os-rebuild-boot = "nh os boot /home/amr/nixos -H laptop";
        nsearch = "nix search nixpkgs";
        grep = "grep --color=auto";
      };
    };

    modules.nixos.laptopHardware = {
      system.stateVersion = "25.11";
      hardware.facter.reportPath = ./facter.json;
      time.timeZone = "Africa/Cairo";
      i18n.defaultLocale = "en_US.UTF-8";
      users.users.root.initialPassword = "root";

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
          grub = {
            enable = true;
            useOSProber = true;
            device = "nodev";
            efiSupport = true;
          };
        };
      };

      ##### File system configuration #####

      services = {
        gvfs.enable = true;
        udisks2.enable = true;
        devmon.enable = true;
      };

      fileSystems = {
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
        "/home/amr/drive" = {
          device = "/dev/disk/by-uuid/b75ce50d-1020-4784-824a-dae35069d641";
          fsType = "ext4";
          options = ["defaults" "noatime"];
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
