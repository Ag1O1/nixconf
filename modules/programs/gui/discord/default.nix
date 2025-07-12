{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.programs.gui.discord;
  discord-wrapped =
    (pkgs.discord.override {
      nss = pkgs.nss_latest;
      withOpenASAR = true;
      withMoonlight = true;
    }).overrideAttrs
      (old: {
        libPath = old.libPath + ":${pkgs.libglvnd}/lib";
        nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.makeWrapper ];

        postFixup = ''
          wrapProgram $out/opt/Discord/Discord \
            --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}}"
        '';
      });
in
{
  options.modules.programs.gui.discord = {
    enable = lib.mkEnableOption "discord";
  };
  config = mkIf cfg.enable {
    #hj.packages = [discord-wrapped];
    hj.packages = [ discord-wrapped ];
  };
}
