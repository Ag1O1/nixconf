{
  pkgs,
  cm,
  ...
}: {
  imports = [cm.openrgb];
  services.hardware.openrgb.enable = true;
  finit.tasks.openrgb-profile = {
    description = "Apply OpenRGB profile at boot";
    runlevels = "2345";
    command = "${pkgs.openrgb}/bin/openrgb --noautoconnect -p keyboard";
    user = "amr";
  };
}
