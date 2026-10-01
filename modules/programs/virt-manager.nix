{
  tags = ["virt"];
  module = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      virt-manager
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      virglrenderer
      qemu
      quickemu
      guestfs-tools
      libvirt
      libvirt-glib
      virtiofsd
    ];
    environment.etc."libvirt/qemu.conf".text = ''
      stdio_handler = "file"
    '';
    finit.services.libvirtd = {
      description = "libvirtd";
      command = "${lib.getExe' pkgs.libvirt "libvirtd"}";
    };
    #programs.virt-manager.enable = true;
    custom.persist.directories = [
      "/var/lib/libvirt"
    ];
  };
}
