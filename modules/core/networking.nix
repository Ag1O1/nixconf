{
  tags = ["core"];
  module = {
    fm,
    pkgs,
    ...
  }: {
    imports = [fm.iwd fm.dhcpcd fm.nftables];

    services = {
      iwd.enable = true;
      dhcpcd.enable = true;
    };
    environment.systemPackages = [
      pkgs.iproute2
      pkgs.openresolv
    ];

    providers.firewall.backend = "nftables";
    services.nftables.enable = true;

    custom.persist.directories = [
      "/etc/iwd/"
      "/etc/dhcpcd.conf"
      "/var/lib/iwd/"
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
