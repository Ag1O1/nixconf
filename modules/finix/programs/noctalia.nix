{
  inputs,
  pkgs,
  fm,
  ...
}: {
  imports = [fm.upower];
  services.upower.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    libnotify
    wl-clipboard-rs
    satty
    glib
    adw-gtk3
    gpu-screen-recorder
  ];
}
