{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.vm;
in {
  options.modules.misc.vm = {
    enable = lib.mkEnableOption "vm";
  };
  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      virglrenderer
      qemu
      quickemu
      guestfs-tools
      libvirt-glib
      virtiofsd
      #virtio-win
      #win-spice
    ];
    programs.virt-manager.enable = true;
  };
}
