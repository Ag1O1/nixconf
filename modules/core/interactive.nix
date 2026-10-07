{
  tags = ["graphical"];
  module = {
    config,
    fm,
    cm,
    ...
  }: {
    imports = [
      fm.gnome-keyring
      fm.polkit
      fm.sessiond-uaccess
      fm.zzz
      fm.brightnessctl
    ];

    services = {
      seatd.enable = true;
      #keventd.enable = true;
      udev.enable = true;
      #mdevd.enable = true;
      sessiond.enable = true;
      sessiond-uaccess.enable = true;

      polkit.enable = true;
    };
    programs = {
      fastfetch.enable = true;
      gnome-keyring.enable = true;
      brightnessctl.enable = true;
    };
    programs.zzz.enable = config.custom.machine.type == "laptop";
  };
}
