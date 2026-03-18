{inputs, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = inputs.linuxmobile-pkgs.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
    environment.systemPackages = [pkgs.xwayland-satellite pkgs.wlr-which-key];
  };
}
