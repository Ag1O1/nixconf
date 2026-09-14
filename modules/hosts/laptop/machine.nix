{lib, ...}: {
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

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";

  hj.xdg.config.files."fish/conf.d/aliases.fish".text = ''
    alias os-rebuild="nh os switch /home/amr/nixos -H laptop"
    alias os-rebuild-boot="nh os boot /home/amr/nixos -H laptop"
  '';
}
