{
  pkgs,
  inputs,
  ...
}: {
  nix = {
    package = pkgs.lix;
    optimise.automatic = true;

    settings = {
      substituters = ["https://hyprland.cachix.org" "https://cosmic.cachix.org/"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  nix.channel.enable = false; # nix channels are not needed when using flakes
  programs.nix-ld.enable = false;
  nixpkgs.config.allowUnfree = true; # its a pain to manage a system without unfree software
  environment.systemPackages = [
    pkgs.nixd
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
