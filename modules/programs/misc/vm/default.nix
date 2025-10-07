{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.vm;
in {
  options.modules.programs.misc.vm = {
    enable = lib.mkEnableOption "vm";
  };
  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          vhostUserPackages = [pkgs.virtiofsd];
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
      #virtio-win
      #win-spice
    ];
    programs.virt-manager.enable = true;
  };
}
