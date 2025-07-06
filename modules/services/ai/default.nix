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

    # ollama cuda seems to currently be broken, using docker for now
    virtualisation.docker = {
      enable = true;
    };
    hardware.nvidia-container-toolkit.enable = true;
    environment.systemPackages = [ pkgs.nvidia-container-toolkit ];
    services = {
      /*
        llama-cpp = {
        enable = true;
        openFirewall = true;
        };
      */
      /*
        ollama = {
          enable = true;
          acceleration = false;
          host = "0.0.0.0";
          port = 11434;
          rocmOverrideGfx = "10.3.0";
          environmentVariables = {
            OLLAMA_FLASH_ATTENTION = "1";
            OLLAMA_KV_CACHE_TYPE = "q4_0";
          };
        };
      */
      open-webui = {
        enable = true;
        package = nixpkgs-stable.open-webui;
      };
    };
  };
}
