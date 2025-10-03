{pkgs, ...}:
pkgs.writeShellApplication {
  name = "auto-start-script";
  runtimeInputs = [
    pkgs.udiskie
    pkgs.waypaper
    pkgs.swaybg
  ];
  text =
    # bash
    ''
      noctalia-shell &
      xrdb ~/.Xresources &
      xsettingsd &
      udiskie &
      swww-daemon &
      swaybg &
      waypaper --restore &
      sleep 3 && discord &
      sleep 6 && zapzap &
      sleep 2 && bitwarden &
      cd /home/amr/projects/rust/discord-ollama && target/release/discord-ollama &
      docker run -d --device=nvidia.com/gpu=all -v ollama:/root/.ollama -p 11434:11434 ollama/ollama &
      cd /home/amr/.local/share/self-hosting/searxng-docker/searxng/ && docker compose up -d &
    '';
}
