{
  flake.modules.nixos.AI = {pkgs, ...}: {
    services = {
      ollama = {
        enable = true;
        openFirewall = true;
        package = pkgs.ollama-vulkan;
      };
      open-webui.enable = true;
    };
  };
}
