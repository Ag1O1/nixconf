{inputs, ...}: {
  flake.modules.nixos.noctalia = {pkgs, ...}: {
    services.gnome.evolution-data-server.enable = true;
    services.upower.enable = true;
    environment.systemPackages = with pkgs; [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;})
      wlsunset
      wl-clipboard-rs
      satty
      app2unit
      glib
      adw-gtk3
      gpu-screen-recorder
      kdePackages.qttools
    ];
  };
}
