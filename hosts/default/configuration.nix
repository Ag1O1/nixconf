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

  networking.hostName = "ag101/nixos";

  # user
  users.users = {
    amr = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "networkmanager" "scanner"];
    };
  };

  system.stateVersion = "24.05";
}
