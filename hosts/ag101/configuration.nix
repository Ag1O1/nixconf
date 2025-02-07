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
  hjem.clobberByDefault = true;

  # hostname
  networking.hostName = "nixos";

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
        "vidio"
        "kvm"
        "libvirt"
      ];
    };
  };

  # module configurations

  modules = {
    hyprland.enable = true;

    programs = {
      gui = {
        firefox.enable = true;
        discord.enable = true;
        fuzzel.enable = true;
        spicetify.enable = true;
      };

      tui = {
        foot.enable = true;
        alacritty.enable = true;
        tmux.enable = true;
        nvf.enable = true;
        direnv.enable = true;
        fish.enable = true;
      };

      misc = {
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
    };

    system = {
      hardware = {
        nvidia.enable = true;
        printing.enable = true;
        opentablet.enable = true;
      };
      greetd.enable = true;
      networking.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
