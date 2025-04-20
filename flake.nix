{
  description = "ag101's flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # hjem
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum/";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.hjem.follows = "hjem";
    };

    # nvf
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # basix
    basix = {
      url = "github:notashelf/basix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # aylur's gtk kit
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify flake
    # for spotify customization
    spicetify-nix.url = "github:gerg-l/spicetify-nix";

    # Declarative flatpaks
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";

    # Cosmic desktop (beta)
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    # umu
    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";

    # niri
    #niri.url = "github:sodiboo/niri-flake"; #requires HM

    # hyprland stuff
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      moduleInputs = with inputs; [
        hjem.nixosModules.default
        nixos-cosmic.nixosModules.default
        #hjem-rum.nixosModules.default
        #spicetify-nix.nixosModules.default
        nvf.nixosModules.default

        flatpaks.nixosModules.declarative-flatpak
      ];
      inherit (builtins) concatLists;
    in
    {
      nixosConfigurations = {
        nixpkgs.overlays = [ inputs.niri.overlays.niri ];
        ag101 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = concatLists [
            moduleInputs
            [
              ./hosts/ag101/configuration.nix
              ./modules
            ]
          ];
        };
      };
    };
}
