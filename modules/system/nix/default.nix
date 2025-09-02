{
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];
  nix = {
    optimise.automatic = true;

    settings = {
      substituters = [
        #"https://hyprland.cachix.org"
        #"https://cosmic.cachix.org"
      ];
      trusted-public-keys = [
        #"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        #"cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  nix.channel.enable = false; # nix channels are not needed when using flakes
  programs.nix-ld.enable = true;
  nixpkgs.config = {
    allowUnfree = true; # its a pain to manage a system without unfree software
    cudaSupport = true;
  };
  environment.systemPackages = [
    pkgs.nixd
    pkgs.nil # Used in basically every project for flake.nix, so makes more sense to have it included in the main config
    pkgs.nixos-rebuild-ng
  ];
  environment.shellAliases = {
    nixos-rebuild = "nixos-rebuild --flake ~/nixos#ag101 --use-remote-sudo";
  };
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
