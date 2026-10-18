{
  tags = ["graphical"];
  module = {
    pkgs,
    config,
    fm,
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
      #udev.enable = true;
      #mdevd.enable = true;
      gardendevd.enable = true;
      sessiond.enable = true;
      sessiond-uaccess.enable = true;
      sessiond-power.enable = true;

      polkit.enable = true;
    };
    programs = {
      gnome-keyring.enable = true;
      brightnessctl.enable = true;
    };
    # Basic graphical apps for desktop envionments
    hj.packages = with pkgs; [
      zathura #PDF viewer
      qimgv #Image viewer
      mpv #Video player
      file-roller #Zip
      pavucontrol #Audio control

      # File manager
      (nemo-with-extensions.override {
        extensions = with pkgs; [nemo-fileroller];
      })
    ];
    programs.zzz.enable = config.custom.machine.type == "laptop";
  };
}
