{...}: {
  flake.modules.nixos.networking = {
    networking = {
      networkmanager = {
        enable = true;
      };
      firewall = {
        enable = true;
        #allowedTCPPorts = [];
      };
    };
  };
}
