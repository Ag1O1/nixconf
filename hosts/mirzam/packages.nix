{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    azure-cli
    cloud-init
    git
    curl
    wget
    jq
    fd
    ripgrep
    file
    tree
    unzip
    zip
    vim
    tmux
    htop
    pciutils
    usbutils
    iproute2
    ethtool
    dnsutils
  ];
}
