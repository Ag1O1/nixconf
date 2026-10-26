{
  tags = ["graphical"];
  module = {
    pkgs,
    fm,
    ...
  }: {
    imports = [fm.tuigreet];
    programs.tuigreet.enable = true;
    custom.persist.files = [
      "/var/cache/tuigreet"
    ];
  };
}
