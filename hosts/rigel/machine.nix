{
  lib,
  pkgs,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = lib.mkForce [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "btrfs"
      ];
    };
  };
  #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  custom = {
    machine = {
      type = "laptop";
      displays."BOE NE160WUM-NXA" = {
        mode = "1920x1200@165";
        vrr = "always";
        direct_scanout = true;
      };
      drm_ignored_pci_addresses = ["0000:01:00.0"];
    };
    nix-serve = {
      host = "192.168.100.20";
    };
    limine.extraEntries = "
    /Gentoo
      protocol: efi
      path: boot():/EFI/gentoo/grubx64.efi

    /Windows
      protocol: efi
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
      ";
  };

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";
  networking.hostName = "rigel";
}
