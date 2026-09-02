{pkgs, ...}: {
  flake.modules.nixos.ly = let
    animation-dur = pkgs.fetchurl {
      url = "https://codeberg.org/fairyglade/ly-community/src/branch/main/animations/dur/blackhole-smooth-240x67.dur";
      hash = "";
    };
  in {
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "dur_file";
        dur_file_path = "${animation-dur}";
      };
    };
  };
}
