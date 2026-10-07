{
  tags = ["core"];
  module = {
    pkgs,
    fm,
    cm,
    ...
  }: {
    imports = [
      fm.gnome-keyring
      fm.bash
      fm.sysklogd
      fm.getty
      fm.iwd
      cm.fastfetch
      fm.fcron
    ];

    finit.runlevel = 3;
    services = {
      sysklogd.enable = true;
      getty.enable = true;
      dbus.enable = true;
      fcron.enable = true;
    };
    programs = {
      fastfetch.enable = true; # yes this is totally a core module
      bash.enable = true;
    };

    environment.systemPackages = with pkgs; [
      microfetch
      btop
      iputils
      tack
      git
      tree
      vim
      wget
      zip
      unzip
      curl
      jq
      fd
      file
      whois
      wget
    ];
  };
}
