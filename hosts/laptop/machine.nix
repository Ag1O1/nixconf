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
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  custom.machine = {
    type = "laptop";
    system_module = "/home/amr/nixos/hosts/laptop/system.nix";
    displays."BOE NE160WUM-NXA" = {
      mode = "1920x1200@165";
      vrr = "always";
      direct_scanout = true;
    };
    drm_ignored_pci_addresses = ["0000:01:00.0"];
  };

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";

  environment.variables.NH_FILE = "/home/amr/nixos/hosts/laptop/system.nix";
}
