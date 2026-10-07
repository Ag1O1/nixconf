{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    azure-cli
    cloud-init
    ripgrep
    tmux
    pciutils
    usbutils
    iproute2
    ethtool
    dnsutils
  ];
}
