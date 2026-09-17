{
  system,
  modules,
}: let
  inputs = import ../.tack;
  inherit (inputs) nixpkgs finix haumea community-modules hjem-rum;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-39.8.10"
      ];
    };
    overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];
  };

  m = haumea.lib.load {
    src = ../modules/finix;
    loader = haumea.lib.loaders.path;
    inputs = {inherit inputs;};
  };
in
  finix.lib.finixSystem {
    inherit (pkgs) lib;
    specialArgs = {
      inherit inputs;
      fm = finix.nixosModules;
      cm = community-modules.nixosModules;
    };
    modules =
      [
        {nixpkgs.pkgs = pkgs;}
        m.services.mime

        m.services.limine.default
        m.services.plymouth

        m.programs.fish
        m.programs.neovim
        m.theming

        ../modules/users/amr.nix
      ]
      ++ modules m
      ++ pkgs.lib.attrValues m.options
      ++ pkgs.lib.attrValues m.core;
  }
