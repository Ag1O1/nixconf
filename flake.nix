{
  description = "My nixconf";

  outputs = {self, ...}: let
    inputs = import ./.tack;
    inherit (inputs) nixpkgs finix haumea community-modules;

    system = "x86_64-linux";
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
      src = ./modules/finix;
      loader = haumea.lib.loaders.path;
      inputs = {inherit inputs;};
    };
    sharedModules =
      [
        m.services.mime

        m.services.limine.default
        m.services.plymouth

        m.programs.fish
        m.programs.neovim
        m.theming
        ./modules/users/amr.nix
      ]
      ++ pkgs.lib.attrValues m.options
      ++ pkgs.lib.attrValues m.core;
  in {
    nixosConfigurations = {
      laptop = finix.lib.finixSystem {
        inherit (pkgs) lib;
        specialArgs = {
          inherit inputs self;
          fm = finix.nixosModules;
          cm = community-modules.nixosModules;
        };
        modules =
          [
            {nixpkgs.pkgs = pkgs;}
          ]
          ++ sharedModules
          ++ [
            ./modules/hosts/laptop/machine.nix
            ./modules/hosts/laptop/hardware.nix
            ./modules/hosts/laptop/packages.nix
            ./modules/hosts/laptop/kernel.nix
            # Hardware
            m.hardware.nvidia
            m.hardware.asusd
            m.hardware.tlp
            m.hardware.bluetooth

            # Programs
            m.programs.nix-search-tv
            m.programs.openrgb
            m.programs.gaming
            m.programs.logisim
            m.programs.tmux
            m.programs.lazygit
            m.programs.obs
            m.programs.waydroid
            m.programs.ly
            m.programs.noctalia
            m.programs.yazi
            m.programs.helium
            m.programs.firefox

            # Services
            m.services.pipewire
            m.services.ssh
            m.services.flatpak
            m.services.printing
            m.services.keyd
            m.services.direnv
            m.services.evolution

            # Desktop
            m.desktop.umbriel
          ];
      };
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [nil nixd alejandra];
    };
  };
}
