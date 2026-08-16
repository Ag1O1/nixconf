{...}: {
  flake.modules.nixos.networking = {
    services.networkmanager.enable = true;
    services.nftables = {
      enable = true;
      configFile = builtins.toFile "nftables.conf" ''
        table inet filter {
          chain input {
            type filter hook input priority 0; policy drop;

            iif "lo" accept
            ct state established,related accept
            ct state invalid drop

            icmp type echo-request accept
            icmpv6 type { echo-request, nd-neighbor-solicit, nd-neighbor-advert, nd-router-advert } accept
          }

          chain forward {
            type filter hook forward priority 0; policy drop;
          }

          chain output {
            type filter hook output priority 0; policy accept;
          }
        }
      '';
    };
  };
}
