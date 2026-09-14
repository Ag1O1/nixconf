{
  inputs,
  pkgs,
  config,
  fm,
  ...
}: {
  imports = [fm.upower];
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    (
      # For polkit to work correctly on finix
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
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
}
