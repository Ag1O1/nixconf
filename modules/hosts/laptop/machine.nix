{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.modules.nixos; [
      # Core
      nix
      core-packages
      laptopHardware
      laptopPackages
      laptopModule
      # User
      user-amr
      # Modules
      theming
      pipewire
      networking
      nvidia
      tlp
      fish
      printing
      keyd
      direnv

      niri
      noctalia

      yazi
      firefox
      gaming
      virt-manager
      emacs
      logisim
    ];
  };
  flake.modules.nixos.laptopModule = {pkgs, ...}: {
    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    services.logind.settings.Login.HandleLidSwitch = "ignore";
    services.flatpak.enable = true;
    virtualisation.waydroid.enable = true;
    programs.kdeconnect.enable = true;

    environment.shellAliases = {
      os-rebuild = "nh os switch /home/amr/nixos -H laptop";
      os-rebuild-boot = "nh os boot /home/amr/nixos -H laptop";
      grep = "grep --color=auto";
    };
    services.displayManager.ly.enable = true;
  };

  flake.modules.nixos.laptopHardware = {
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
        "zswap.enabled=0"
        "amdgpu.dcdebugmask=0x410"
        "amdgpu.sg_display=0"
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

    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.devmon.enable = true;

    fileSystems."/" = {
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

    fileSystems."/home" = {
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

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd:1"
        "noatime"
        "discard=async"
      ];
    };

    fileSystems."/mnt/swap" = {
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      options = [
        "subvol=@swap"
        "noatime"
      ];
    };

    swapDevices = [
      {device = "/mnt/swap/swapfile";}
    ];

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/66E7-77B4";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    fileSystems."/home/amr/drive" = {
      device = "/dev/disk/by-uuid/b75ce50d-1020-4784-824a-dae35069d641";
      fsType = "ext4";
      options = ["defaults" "noatime"];
    };
  };
}
