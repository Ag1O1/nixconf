{
  tags = ["rigel"];
  module = {pkgs, ...}: {
    environment.systemPackages = [pkgs.ollama-cuda];
    custom.persist.directories = [
      "/var/lib/ollama"
    ];
    finit.services.ollama = {
      environment = {
        HOME = "/var/lib/ollama";
        OLLAMA_MODELS = "/var/lib/ollama/models";
        OLLAMA_HOST = "127.0.0.1:11434";
      };
      command = "ollama serve";
    };
    providers.firewall.allowedTCPPorts = [11434];
  };
}
