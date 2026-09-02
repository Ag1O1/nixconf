{
  flake.modules.nixos.ly = {pkgs, ...}: let
    animation-dur = pkgs.fetchurl {
      url = "https://codeberg.org/fairyglade/ly-community/raw/branch/main/animations/dur/blackhole-smooth-240x67.dur";
      hash = "";
    };
  in {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "dur_file";
        dur_file_path = "${animation-dur}";
      };
    };
  };
}
