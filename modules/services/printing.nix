{
  tags = ["graphical"];
  module = {
    pkgs,
    cm,
    ...
  }: let
    sane_package = pkgs.sane-backends;
  in {
    imports = [
      cm.cups
    ];

    services.cups = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin]; # Note: HAS TO BE WITH PLUGIN OR THE PRINTER WONT WORK
    };

    environment.systemPackages = [pkgs.simple-scan pkgs.sane-backends];

    environment.variables = {
      SANE_CONFIG_DIR = "${sane_package}/etc/sane.d";
      LD_LIBRARY_PATH = "${sane_package}/lib";
    };

    custom.persist.directories = [
      "/etc/cups/"
    ];
  };
}
