{
  tags = ["asus"];
  module = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # Asusd doesn't work with the current libudev-zero. As it doesn't add the devices asusd needs.
    # I do not fully understand it and I'll admit I had to use claude to write me this patch.
    # I am planning on looking into it more deeply and write my own patch or fork.
    # The patch fixes the issue and allows asusd to work although battery settings still don't.
    libudev-zero = pkgs.libudev-zero.overrideAttrs (o: {
      patches = (o.patches or []) ++ [./libudev-zero-patches.patch];
    });
    udevApi =
      if config.services.gardendevd.enable
      then pkgs.libudev-garden
      else if config.services.mdevd.enable || config.services.keventd.enable
      then libudev-zero
      else null;
    libinput = pkgs.libinput.override (
      lib.optionalAttrs (udevApi != null) {
        udev = udevApi;
        wacomSupport = false;
      }
    );
    package = pkgs.asusctl.override {
      inherit libinput;
      systemd = udevApi;
    };
  in {
    environment.systemPackages = [
      package
    ];
    services.dbus.packages = [package];
    finit.services.asusd = {
      description = "asusd";
      runlevels = "2345";
      command = "${lib.getExe' package "asusd"}";
    };
    custom.persist = {
      files = [
        "/etc/supergfxd.conf"
      ];
      directories = [
        "/etc/asusd"
      ];
    };
  };
}
