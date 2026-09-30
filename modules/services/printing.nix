{
  pkgs,
  cm,
  ...
}: {
  imports = [
    cm.cups
  ];

  services.cups = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin]; # Note: HAS TO BE WITH PLUGIN OR THE PRINTER WONT WORK
  };

  environment.systemPackages = [pkgs.simple-scan];

  custom.persist.directories = [
    "/etc/cups/"
  ];
}
