{
  pkgs,
  lib,
  ...
}: {
  finit.services.nix-serve = {
    description = "asusd";
    command = "${lib.getExe' pkgs.nix-serve} --listen-host 192.168.10.20 --port 5000 --secret-key /etc/nix/cache-private-key.pem";
  };
  custom.persist.files = [
    "/etc/nix/cache-private-key.pem"
    "/etc/nix/cache-public-key.pem"
  ];
}
