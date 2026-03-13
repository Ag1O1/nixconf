{...}: {
  flake.modules.nixos.core = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    environment.systemPackages = with pkgs; [
      microfetch
      git
      tree
      vim
      wget
    ];
  };
}
