{inputs, ...}: {
  flake.modules.nixos.sops = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/amr/.config/sops/age/keys.txt";

      secrets = {
        searxng_key = {};
        user_pass = {
          neededForUsers = true;
        };
        root_pass = {
          neededForUsers = true;
        };
      };
    };
  };
}
