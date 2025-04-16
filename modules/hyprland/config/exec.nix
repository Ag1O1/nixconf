{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.hyprland.enable {
    hj.rum.programs.hyprland.settings = {
      exec-once = [
        "ags -c ~/.config/ags/config.js"
        "sleep 8 ; discord"
        "ngrok http --url=goose-neat-sponge.ngrok-free.app 8080"
        "hyprctl setcursor Bibata-Modern-Ice 24"
        "hyprpaper"
        "$browser"
        "cd /home/amr/projects/rust/discord-ollama/flake && nix develop"
        "[workspace 3] zapzap"
        "${lib.getExe' pkgs.udiskie "udiskie"}"
        "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit"
        "${lib.getExe' pkgs.wl-clipboard "wl-paste"} -t text --watch ${lib.getExe' pkgs.clipman "clipman"} store --no-persist"
        "/home/amr/projects/rust/discord-ollama/target/release/discord-ollama"
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
