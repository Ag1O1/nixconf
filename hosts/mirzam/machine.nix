{
  lib,
  cm,
  fm,
  pkgs,
  ...
}: {
  imports = [cm.minimal fm.sudo];
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_net"
  ];
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  profiles.minimal.enable = true;
  profiles.minimal.deviceManager = "mdevd";
  profiles.minimal.withFlakes = false;

  custom = {
    machine = {
      type = "headless";
    };
  };

  networking.hostName = "mirzam";
}
