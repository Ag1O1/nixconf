{
  fm,
  config,
  cm,
  lib,
  pkgs,
  ...
}: {
  imports = [fm.gnome-keyring fm.bash fm.sysklogd fm.polkit fm.getty fm.iwd cm.fastfetch fm.sessiond-uaccess fm.zzz fm.brightnessctl];
  boot = {
    initrd = {
      #includeDefaultModules = lib.mkForce false;
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
  programs.fastfetch.enable = true;

  finit.runlevel = 3;

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";

  services = {
    sysklogd.enable = true;
    getty.enable = true;
    dbus.enable = true;

    udev.enable = true;
    seatd.enable = true;

    sessiond.enable = true;
    sessiond-uaccess.enable = true;

    polkit.enable = true;
  };
  programs.zzz.enable = true;

  providers = {
    resumeAndSuspend.backend = "zzz";

    privileges.rules = [
      {
        command = "/run/current-system/sw/bin/poweroff";
        groups = [config.services.seatd.group];
        requirePassword = false;
      }
      {
        command = "/run/current-system/sw/bin/reboot";
        groups = [config.services.seatd.group];
        requirePassword = false;
      }
      {
        command = "/run/current-system/sw/bin/zzz";
        groups = [config.services.seatd.group];
        requirePassword = false;
      }
      {
        command = "/run/current-system/sw/bin/ZZZ";
        groups = [config.services.seatd.group];
        requirePassword = false;
      }
    ];
  };

  programs = {
    bash.enable = true;
    gnome-keyring.enable = true;
    brightnessctl.enable = true;
  };

  hj.xdg.config.files."fish/conf.d/aliases.fish".text = ''
    alias os-rebuild="nh os switch /home/amr/nixos -H laptop"
    alias os-rebuild-boot="nh os boot /home/amr/nixos -H laptop"
  '';
}
