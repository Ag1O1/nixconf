{inputs, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = [pkgs.xwayland-satellite pkgs.wlr-which-key pkgs.hyprmagnifier];
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
