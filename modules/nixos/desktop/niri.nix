{inputs, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = inputs.linuxmobile-pkgs.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
    environment.systemPackages = [pkgs.xwayland-satellite pkgs.wlr-which-key pkgs.wooz];
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = ["gnome"];
    };
  };
}
