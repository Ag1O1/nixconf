{ ... }: {
  flake.nixosModules.core = {pkgs, ...} {
    environment.systemPackages = with pkgs; [
      git
      tree
      vim
      wget
    ];
  };
}
