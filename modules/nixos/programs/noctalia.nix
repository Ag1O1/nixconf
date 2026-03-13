{
  flake.modules.nixos.noctalia = {
    inputs,
    pkgs,
    ...
  }: {
    services.gnome.evolution-data-server.enable = true;
    environment.systemPackages = with pkgs; [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;})
      wlsunset
      app2unit
      glib
    ];
  };
}
