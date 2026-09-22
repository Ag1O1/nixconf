{
  inputs,
  system,
  pkgs,
  config,
  fm,
  ...
}: {
  imports = [fm.upower];
  services.upower.enable = true;

  hj.packages = with pkgs; [
    (
      # For polkit to work correctly on finix
      inputs.noctalia.packages.${system}.default.override {
        polkit = config.services.polkit.package;
      }
    )
    libnotify
    wl-clipboard-rs
    satty
    glib
    adw-gtk3
    gpu-screen-recorder
  ];
  hj.xdg.config.files."noctalia/config.toml".source = ./config.toml;
}
