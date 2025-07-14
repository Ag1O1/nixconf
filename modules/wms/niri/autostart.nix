{pkgs, ...}:
pkgs.writeShellApplication {
  name = "auto-start-script";
  runtimeInputs = [
    pkgs.udiskie
    pkgs.waypaper
    pkgs.swaybg
    pkgs.xwayland-satellite
  ];
  text =
    # bash
    ''
      xwayland-satellite &
      cd /home/amr/projects/rust/discord-ollama && target/release/discord-ollama &
      swww-daemon &
      swaybg &
      waypaper --restore &
      udiskie &
      bitwarden &
      xrdb ~/.Xresources &
      xsettingsd &
      docker run -d --device=nvidia.com/gpu=all -v ollama:/root/.ollama -p 11434:11434 ollama/ollama &
      cd /home/amr/.local/share/self-hosting/searxng-docker/searxng/ && docker compose up -d &


    '';
}
