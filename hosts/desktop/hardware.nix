{
  pkgs,
  config,
  fm,
  ...
}: {
  imports = [fm.gvfs fm.udisks2];
  hardware.firmware = [pkgs.linux-firmware];
  hardware.nvidia = {
    kernelModule = "closed";
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid"];
  boot.kernelModules = ["kvm-intel"];

  hardware.cpu.intel.updateMicrocode = true;

  ##### File system configuration #####

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/bad7780e-1249-4715-90a2-0bed0adf68ed";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0851-2CC7";
      fsType = "vfat";
      neededForBoot = true;
      options = ["fmask=0077" "dmask=0077"];
    };
  };
}
