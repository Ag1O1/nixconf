{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  fileSystems."/run/media/amr/Disk" = {
    device = "/dev/disk/by-uuid/c17b40f4-a9c5-4f7a-b4fc-9767f988cb69";
    fsType = "ext4";
  };

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
