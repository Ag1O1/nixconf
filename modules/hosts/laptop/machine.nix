{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.modules.nixos.core
      self.modules.nixos.laptopHardware
      self.modules.nixos.laptopModule
      self.modules.nixos.yazi
      self.modules.nixos.fish
      self.modules.nixos.laptopPackages
      self.modules.nixos.nvidia
      self.modules.nixos.printing
      self.modules.nixos.user-amr
      #self.modules.nixos.testModule
      self.modules.nixos.niri
      self.modules.nixos.pipewire
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
      efi.canTouchEfiVariables = false;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };

    fileSystems."/" = {
      device = "UUID=430c366d-f6d8-4592-a26a-561a29d94de1";
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
      device = "UUID=430c366d-f6d8-4592-a26a-561a29d94de1";
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
      device = "UUID=430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd:1"
        "noatime"
        "discard=async"
      ];
    };

    fileSystems."/mnt/swap" = {
      device = "UUID=430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      options = [
        "subvol=@swap"
        "noatime"
      ];
    };

    swapDevices = [
      {device = "/mnt/swap/swapfile";}
    ];

    fileSystems."/home/amr/drive" = {
      device = "UUID=b75ce50d-1020-4784-824a-dae35069d641";
      fsType = "ext4";
      options = ["defaults" "noatime"];
    };
  };
}
