{
  lib,
  config,
  pkgs,
  ...
}: let
  auto-start-script = import ./autostart.nix {inherit pkgs;};
in {
  config = lib.mkIf config.modules.wms.hyprland.enable {
    hj.rum.desktops.hyprland.settings = {
      #exec-once = [auto-start-script];
      exec-once = [
        "noctalia-shell"
        "xrdb ~/.Xresources"
        "xsettingsd"
        "udiskie"
        "sleep 3 && discord"
        "sleep 2 && zapzap"
        "sleep 2 && bitwarden"
        "cd /home/amr/projects/rust/discord-ollama && target/release/discord-ollama"
        "docker run -d --device=nvidia.com/gpu=all -v ollama:/root/.ollama -p 11434:11434 ollama/ollama"
        "cd /home/amr/.local/share/self-hosting/searxng-docker/searxng/ && docker compose up -d"
      ];

      windowrulev2 = [
        "workspace 4 silent,class:^(discord)$"
        "float, class:^(conhost.exe)$"
        "float, class:^(explorer.exe)$"
        "float, class:^(org.gnome.Nautilus)$"
        "noborder, onworkspace:w[t1]"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "suppressevent maximize, class:.*" # You'll probably like this.
        #"immediate, class:^(American Truck Simulator)$"
      ];
    };
  };
}
