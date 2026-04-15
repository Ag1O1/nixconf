{
  flake.modules.nixos.AI = {pkgs, ...}: {
    services = {
      ollama = {
        enable = true;
        openFirewall = true;
        package = pkgs.ollama-cuda;
      };
      open-webui.enable = true;
    };
  };
}
