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
  networking.hostName = "nixos";
  services.desktopManager.plasma6.enable = true; # TEMP
  services.displayManager.sddm.enable = true; # TEMP

  # user
  users.users = {
    amr = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "networkmanager" "scanner"];
    };
  };

  modules = {
    hyprland.enable = true;

    services = {
      pipewire.enable = true;
    };

    programs = {
      gui = {
        firefox.enable = true;
        discord.enable = true;
      };
      tui = {
        foot.enable = true;
      };
    };

    system = {
      hardware = {
        nvidia.enable = true;
        printing.enable = true;
      };
    };
  };

  system.stateVersion = "24.05";
}
