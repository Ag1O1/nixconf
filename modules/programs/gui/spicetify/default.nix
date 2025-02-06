{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.gui.spicetify;
in {
  options.modules.gui.spicetify = {
    enable = lib.mkEnableOption "spicetify";
  };
  imports = [inputs.spicetify-nix.nixosModules.default];
  config = mkIf cfg.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        powerBar
        fullAlbumDate
        fullAppDisplay
        listPlaylistsWithSong
        playNext
        volumePercentage
      ];
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
        newReleases
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
