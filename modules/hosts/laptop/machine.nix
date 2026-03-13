{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # Core
      self.modules.nixos.core
      self.modules.nixos.laptopHardware
      self.modules.nixos.laptopPackages
      self.modules.nixos.laptopModule
      # User
      self.modules.nixos.user-amr
      # Modules
      self.modules.nixos.pipewire
      self.modules.nixos.nvidia
      self.modules.nixos.fish
      self.modules.nixos.printing

      self.modules.nixos.niri
      self.modules.nixos.noctalia

      self.modules.nixos.yazi
    ];
  };
  flake.modules.nixos.laptopModule = {...}: {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "niri-session";
          user = "amr";
        };
        default_session = initial_session;
      };
    };
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

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };

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
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "ext4";
      options = ["defaults" "noatime"];
    };
  };
}
