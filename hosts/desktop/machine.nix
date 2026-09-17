{
  lib,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v4;
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  custom.machine = {
    type = "desktop";
    system_module = "/home/amr/nixos/hosts/desktop/system.nix";
    displays."Samsung Electric Company SMBX2331 0x4E464436" = {
      mode = "1920x1080@60";
      direct_scanout = true;
    };
  };

  services.nix-daemon.settings = {
    substituters = ["192.168.100.20:5000"];
    trusted-public-keys = ["laptop:plYrTT/BdBRRWVZy9LQ+rDMjnyTCRkxC1O9WQ/HKypw="];
  };

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";
}
