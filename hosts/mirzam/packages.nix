{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    azure-cli
    cloud-init
    ripgrep
    tmux
    iproute2
    ethtool
  ];
}
