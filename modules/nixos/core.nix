{...}: {
  flake.nixosModules.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      microfetch
      git
      tree
      vim
      wget
    ];
  };
}
