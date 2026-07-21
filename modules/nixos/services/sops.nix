{inputs, ...}: {
  flake.modules.nixos.sops = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = ./secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "home/amr/.config/sops/age/keys.txt";

      secrets = {
        searxng_key = {};
      };
    };
  };
}
