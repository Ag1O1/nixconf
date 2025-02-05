{
  description = "ag101's flake (attempted refactor)";

  inputs = {
    # hjem
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvf
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix pkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nix colors
    nix-colors.url = "github:misterio77/nix-colors";

    # aylur's gtk kit
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify flake
    # for spotify customization
    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };
    moduleInputs = with inputs; [
      hjem.nixosModules.default
      spicetify-nix.nixosModules.default
      nvf.nixosModules.default
    ];
    inherit (builtins) concatLists;
  in {
    nixosConfigurations = {
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
