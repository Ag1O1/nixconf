{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.asusd.enable = true;

  # TODO
  #fileSystems."/run/media/amr/Disk" = {
  #  device = "/dev/disk/by-uuid/d2f9345e-a3be-42c4-a695-1218fee27862";
  #  fsType = "ext4";
  #};

  # encrypted device
  boot.initrd.luks.devices."luks-40f7a02e-be74-48d1-b150-a3aef34c9b5e".device =
    "/dev/disk/by-uuid/40f7a02e-be74-48d1-b150-a3aef34c9b5e";
  #boot.initrd.luks.devices."luks-d2f9345e-a3be-42c4-a695-1218fee27862".device =
  #  "/dev/disk/by-uuid/d2f9345e-a3be-42c4-a695-1218fee27862";

  ## for ntfs (windows) drives
  #boot.supportedFilesystems = [ "ntfs" ];
  #fileSystems."/run/media/amr/Disk" = {
  #  device = "/dev/disk/by-uuid/C0C8B459C8B45000";
  #  fsType = "ntfs-3g";
  #  options = [
  #    "rw"
  #    "uid=1000"
  #  ];
  #};
}
