{
  tags = ["core"];
  module = {
    pkgs,
    fm,
    cm,
    ...
  }: {
    imports = [
      fm.bash
      fm.sysklogd
      fm.getty
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
      coreutils.package = pkgs.busybox;
      sh.package = pkgs.busybox.overrideAttrs (o: {
        meta = o.meta // {mainProgram = "ash";};
      });
    };

    environment.systemPackages = with pkgs; [
      microfetch
      btop
      tack
      git
      curl
      jq
      fd
      whois
    ];
  };
}
