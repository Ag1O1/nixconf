{
  tags = ["rigel"];
  module = {
    lib,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.ollama-cuda];
    custom.persist.directories = [
      "/var/lib/ollama"
    ];
    finit.services.ollama = {
      description = "ollama";
      runlevels = "2345";
      environment = {
        HOME = "/var/lib/ollama";
        OLLAMA_MODELS = "/var/lib/ollama/models";
        OLLAMA_HOST = "127.0.0.1:11434";
      };
      command = "${lib.getExe pkgs.ollama-cuda} serve";
    };
    providers.firewall.allowedTCPPorts = [11434];
  };
}
