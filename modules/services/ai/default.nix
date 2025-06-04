{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.services.ai;
  nixpkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{

  options.modules.services.ai = {
    enable = lib.mkEnableOption "ai";
  };
  config = mkIf cfg.enable {
    services = {
      /*
        llama-cpp = {
        enable = true;
        openFirewall = true;
        };
      */
      ollama = {
        enable = true;
        acceleration = "cuda";
        package = nixpkgs-stable.ollama;
        environmentVariables = {
          OLLAMA_FLASH_ATTENTION = "1";
          OLLAMA_KV_CACHE_TYPE = "q4_0";
        };
      };
      open-webui = {
        enable = true;
        package = nixpkgs-stable.open-webui;
      };
    };
  };
}
