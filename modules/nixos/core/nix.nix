{inputs, ...}: {
  flake.modules.nixos.nix = {
    pkgs,
    lib,
    ...
  }: {
    nix = {
      optimise.automatic = true;
      package = pkgs.lix;

      settings = {
        cores = 8;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
    nix.channel.enable = false; # nix channels are not needed when using flakes
    programs = {
      nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc.lib
          zlib
        ];
      };
    };

    services = {
      envfs = {
        enable = true;
      };
    };

    nixpkgs.config = {
      allowUnfree = true; # its a pain to manage a system without unfree software
    };
    environment.systemPackages = [
      pkgs.nixd
      pkgs.package-version-server
      pkgs.nil # Used in basically every project for flake.nix, so makes more sense to have it included in the main config
    ];
    nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];
    # My configuration uses nh as a replacement for the default nixos rebuild command
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = lib.mkDefault "/home/amr/nixos"; # This is the location for the config in all my devices but can be overwritten
    };
  };
}
