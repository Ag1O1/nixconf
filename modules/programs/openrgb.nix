{
  tags = ["laptop"];
  module = {cm, ...}: {
    imports = [cm.openrgb];
    services.hardware.openrgb.enable = true;
  };
}
