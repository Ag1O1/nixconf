{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hjem.finixModules.default

    (
      lib.mkAliasOptionModule
      ["hj"]
      [
        "hjem"
        "users"
        "amr"
      ]
    )
  ];
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_net"
  ];
  hardware.firmware = [pkgs.linux-firmware];

  boot = {
    kernelParams = [
      "console=tty0"
      "console=ttyS0,115200"
    ];
  };
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  services.mdevd.enable = true;

  users.users.amr = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
  environment.etc."ssh/authorized_keys_amr" = {
    text = ''
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINn+ES5xhxttLQTC2f4oqpPs62gFEknY+Q9GX/X0kWeG amr@rigel"
    '';
    mode = "0600";
    user = "amr";
    group = "users";
  };
  hj = {
    enable = true;
  };

  services.openssh.settings.AuthorizedKeysFile = "/etc/ssh/authorized_keys_amr";

  custom = {
    machine = {
      type = "headless";
    };
  };

  networking.hostName = "mirzam";
}
