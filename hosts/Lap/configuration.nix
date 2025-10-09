# main configuration
# this should remain short and only to set and enable settings from custom modules
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  user = "amr";
in {
  imports = [
    ./hardware-configuration.nix
    #./hardware
    ./packages.nix
    (
      lib.mkAliasOptionModule
      ["hj"]
      [
        "hjem"
        "users"
        "${user}"
      ]
    )
  ];
  #hjem stuff
  hjem = {
    users.amr = {
      enable = true;
      directory = "/home/amr";
      user = "amr";
    };
    clobberByDefault = true;
    extraModules = [
      inputs.hjem-rum.hjemModules.default
    ];
  };
  # hostname
  networking.hostName = "nixos";
  #networking.useDHCP = lib.mkDefault true;

  # encrypted device | temp location
  boot.initrd.luks.devices."luks-40f7a02e-be74-48d1-b150-a3aef34c9b5e".device = "/dev/disk/by-uuid/40f7a02e-be74-48d1-b150-a3aef34c9b5e";
  # user
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  users.users = {
    amr = {
      initialPassword = "password";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "kvm"
        "libvirt"
        "docker"
      ];
    };
  };

  # module configurations

  modules = {
    programs = {
      gui = {
        firefox.enable = true;
        discord.enable = true;
        noctalia.enable = true;
        spicetify.enable = true;
        obs.enable = false;
      };

      tui = {
        tmux.enable = true;
        nvf.enable = true;
        direnv.enable = true;
        fish.enable = true;
      };

      misc = {
        gaming.enable = true;
        git.enable = true;
      };
    };

    services = {
      pipewire.enable = true;
      bluetooth.enable = true;
      polkit.enable = true;
      mime.enable = true;
      security.enable = true;
    };

    system = {
      hardware = {
        nvidia.enable = true;
        printing.enable = true;
      };

      networking.enable = true;
    };
    wms = {
      niri.enable = true;
    };
  };
  networking.firewall = {
    allowedUDPPorts = [10999]; # 10999 for don't starve together
    allowedTCPPorts = [10999];
  };
  hardware.nvidia.open = true;

  environment.variables = {
    PROTONPATH = "GE-Proton";
    NIXPKGS_ALLOW_UNFREE = 1;
    GAMEID = "0";
  };
  environment.shellAliases = {
    os-rebuild = "nh os switch /home/amr/nixos -H lap";
    os-rebuild-boot = "nh os boot /home/amr/nixos -H lap";
    grep = "grep --color=auto";
  };

  services.flatpak.enable = true;

  services.hardware.openrgb = {
    enable = true;
    #package = pkgs.openrgb-hardwaresync;
    motherboard = "amd";
  };
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.labwc.enable = true;
  /*
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
  */
  system.stateVersion = "24.05";
}
