{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.programs.tui.fish;
in
{
  options.modules.programs.tui.fish = {
    enable = lib.mkEnableOption "fish";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      #   inputs.umu.packages.${pkgs.system}.umu
      (pkgs.writers.writeFishBin "nrun" ''
        if echo "$argv[1]" | grep -Eq '^[a-z]+:.+/.+$'
            nix run $argv[1] -- $argv[2..]
        else
            nix run nixpkgs#$argv[1] -- $argv[2..]
        end
      '')
      (pkgs.writers.writeFishBin "nsh" ''
        if echo "$argv[1]" | grep -Eq '^[a-z]+:.+/.+$'
          nix shell $argv[1] -- $argv[2..]
        else
          nix shell nixpkgs#$argv[1] -- $argv[2..]
        end
      '')
    ];
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
  };
}
