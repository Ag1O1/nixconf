{
  system,
  extraModules ? [],
  tags ? [],
}: let
  inputs = import ../.tack;
  inherit (inputs) nixpkgs finix community-modules;
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

  allFiles = pkgs.lib.filesystem.listFilesRecursive ../modules;
  isModule = path: let
    baseName = baseNameOf path;
  in
    pkgs.lib.hasSuffix ".nix" baseName && !pkgs.lib.hasPrefix "_" baseName;

  modulePaths = builtins.filter isModule allFiles;

  importedModules = map import modulePaths;

  activeTags = ["options"] ++ tags;
  hasMatchingTag = mod:
    mod ? tags && pkgs.lib.any (tag: pkgs.lib.elem tag activeTags) mod.tags;

  matchedModules = pkgs.lib.filter hasMatchingTag importedModules;
  activeConfigs = map (mod: mod.module) matchedModules;
in
  finix.lib.finixSystem {
    inherit (pkgs) lib;
    specialArgs = {
      inherit inputs;
      inherit system;
      fm = finix.nixosModules;
      cm = community-modules.nixosModules;
    };
    modules =
      [
        {
          nixpkgs.pkgs = pkgs;
        }
      ]
      ++ activeConfigs
      ++ extraModules;
  }
