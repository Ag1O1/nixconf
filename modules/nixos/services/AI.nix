{
  inputs,
  system,
  ...
}: {
  flake.modules.nixos.AI = {pkgs, ...}: let
  in {
    services = {
      ollama = {
        enable = true;
        openFirewall = true;
        package = pkgs.ollama-cuda;
      };
      /*
      open-webui = {
        enable = true;
        package = pkgsStable.open-webui;
      };
      */
    };
  };
}
