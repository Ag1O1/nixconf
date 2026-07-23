{
  inputs,
  system,
  ...
}: {
  flake.modules.nixos.AI = {pkgs, ...}: let
    pkgsStable = import inputs.nixpkgs-stable {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  in {
    services = {
      ollama = {
        enable = true;
        openFirewall = true;
        package = pkgs.ollama-cuda;
      };
      # For some reason openwebUI started hogging all of the internet
      /*
      open-webui = {
        enable = true;
        package = pkgsStable.open-webui;
      };
      */
    };
  };
}
