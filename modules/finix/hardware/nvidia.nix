{
  config,
  lib,
  ...
}:
with lib; {
  hardware = {
    graphics.enable = true;
    nvidia = {
      enable = true;
      modesetting.enable = true;
      kernelModule = "open";
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "610.43.03";

        sha256_64bit = "sha256-ReLUwTSiPDXlDyU6SqY+fl6NF+PRhdSgfIpY6WEu05I=";
        openSha256 = "sha256-QCXmqo2xNyIwjGv0da2MUC8ex641Mmc5DUI+uRFVwgE=";
        settingsSha256 = lib.fakeHash;
        persistencedSha256 = lib.fakeHash;
      };
      power = {
        suspend.enable = true;
        runtime.enable = true;
      };
    };
  };
}
