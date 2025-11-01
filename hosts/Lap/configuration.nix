# main configuration
# this should remain short and only to set and enable settings from custom modules
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  user = "amr";
in
{
  imports = [
    ./hardware-configuration.nix
    ./hardware
    ./packages.nix
    (lib.mkAliasOptionModule
      [ "hj" ]
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
        obs.enable = true;
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
    allowedUDPPorts = [ 10999 ]; # 10999 for don't starve together
    allowedTCPPorts = [ 10999 ];
  };
  virtualisation.waydroid.enable = true;
  # TODO: Put in its own hardware config file
  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="bluetooth wifi wwan";
      NMI_WATCHDOG=0; # Set to 1 if debugging
      CPU_DRIVER_OPMODE_ON_AC="active";
      CPU_DRIVER_OPMODE_ON_BAT="active";
      RADEON_DPM_STATE_ON_AC="performance";
      RADEON_DPM_STATE_ON_BAT="battery";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_BAT = 0;
      PLATFORM_PROFILE_ON_BAT = "balanced";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      PLATFORM_PROFILE_ON_AC = "performance";
      USB_AUTOSUSPEND = 0;
    };
  };
  services.power-profiles-daemon.enable = lib.mkForce false;
  powerManagement.powertop.enable = true;
  services.supergfxd.enable = true;
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia = {
    open = true;
    powerManagement.finegrained = false;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:102:0:0";
    };
  };

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
  services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;
  services.gnome.evolution-data-server.enable = true;
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
