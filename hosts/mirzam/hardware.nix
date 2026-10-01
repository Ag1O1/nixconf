{pkgs, ...}: {
  hardware.firmware = [pkgs.linux-firmware];

  boot = {
    kernelParams = [
      "console=tty0"
      "console=ttyS0,115200"
    ];
  };
}
