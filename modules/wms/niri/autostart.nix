{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "auto-start-script";
  runtimeInputs = [
    pkgs.udiskie
    pkgs.waypaper
    pkgs.swww
    pkgs.swaybg
    pkgs.xwayland-satellite
  ];
  text =
    # bash
    ''
      xwayland-satellite &
      /home/amr/projects/rust/discord-ollama/target/release/discord-ollama &
      swww-daemon &
      swaybg &
      waypaper --restore &
      udiskie &
      bitwarden &

    '';
}
