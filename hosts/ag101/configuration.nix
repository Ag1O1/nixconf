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
    ./hardware
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
        eden.enable = true;
        firefox.enable = true;
        discord.enable = true;
        fuzzel.enable = false;
        spicetify.enable = true;
        #sober.enable = false;
        obs.enable = true;
        mako.enable = true;
      };

      tui = {
        ghostty.enable = true;
        foot.enable = true;

        tmux.enable = true;
        nvf.enable = true;
        direnv.enable = true;
        fish.enable = true;
      };

      misc = {
        docker.enable = true;
        gaming.enable = true;
        vm.enable = true;
        git.enable = true;
      };
    };

    services = {
      pipewire.enable = true;
      bluetooth.enable = true;
      ai.enable = true;
      polkit.enable = true;
      mime.enable = true;
      security.enable = true;
    };

    system = {
      hardware = {
        nvidia.enable = true;
        printing.enable = true;
        opentablet.enable = true;
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

  environment.variables = {
    PROTONPATH = "GE-Proton";
    NIXPKGS_ALLOW_UNFREE = 1;
    GAMEID = "0";
  };
  environment.shellAliases = {
    os-rebuild = "sudo nixos-rebuild switch --flake /home/amr/nixos#ag101";
    os-rebuild-boot = "sudo nixos-rebuild boot --flake /home/amr/nixos#ag101";
    ls = "${lib.getExe pkgs.lsd}";
    cat = "${lib.getExe pkgs.bat}";
    grep = "grep --color=auto";
  };

  services.flatpak.enable = true;

  services.hardware.openrgb = {
    enable = true;
    #package = pkgs.openrgb-hardwaresync;
    motherboard = "amd";
  };

  services.displayManager.ly.enable = true;
  system.stateVersion = "24.05";
}
