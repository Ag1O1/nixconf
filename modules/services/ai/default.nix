{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.ai;
in {
  options.modules.services.ai = {
    enable = lib.mkEnableOption "ai";
  };
  config = mkIf cfg.enable {
    services = {
      ollama.enable = true;
      ollama.acceleration = "cuda";
      ollama.package = pkgs.ollama;
      ollama.environmentVariables = {
        OLLAMA_FLASH_ATTENTION = "1";
        OLLAMA_KV_CACHE_TYPE = "q4_0";
      };
      open-webui.enable = true;
    };
  };
}
