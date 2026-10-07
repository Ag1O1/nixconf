{
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_net"
  ];
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  services.mdevd.enable = true;

  custom = {
    machine = {
      type = "headless";
    };
  };

  networking.hostName = "mirzam";
}
