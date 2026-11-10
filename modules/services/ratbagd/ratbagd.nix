{
  tags = ["rigel"];
  module = {fm, ...}: {
    imports = [fm.ratbagd];
    services.ratbagd.enable = true;
  };
}
