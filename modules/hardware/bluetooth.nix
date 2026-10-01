{
  tags = ["betelgeuse" "rigel"];
  module = {fm, ...}: {
    imports = [fm.bluetooth];
    services.bluetooth.enable = true;
    custom.persist.directories = [
      "/var/lib/bluetooth"
    ];
  };
}
