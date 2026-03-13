{...}: {
  flake.modules.nixos.core-packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      microfetch
      git
      tree
      vim
      wget
    ];
  };
}
