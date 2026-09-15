{
  config,
  pkgs,
  fm,
  cm,
  ...
}: {
  imports = [fm.gnome-keyring fm.bash fm.sysklogd fm.polkit fm.getty fm.iwd cm.fastfetch fm.sessiond-uaccess fm.zzz fm.brightnessctl];
  finit.runlevel = 3;
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
  programs = {
    fastfetch.enable = true;
    bash.enable = true;
    gnome-keyring.enable = true;
    brightnessctl.enable = true;
  };
  programs.zzz.enable = config.custom.machine.type == "laptop";

  environment.systemPackages = with pkgs; [
    microfetch
    tack
    git
    tree
    vim
    wget
    unzip
  ];
}
