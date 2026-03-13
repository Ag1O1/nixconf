{...}: {
  flake.modules.nixos.core = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      microfetch
      git
      tree
      vim
      wget
    ];
  };
}
