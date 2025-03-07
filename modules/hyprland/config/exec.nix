{
  lib,
  pkgs,
  ...
}: {
  hj.rum.programs.hyprland.settings = {
    exec-once = [
      "ags -c ~/.config/ags/config.js"
      "sleep 8 ; discordcanary"
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
      "suppressevent maximize, class:.*" # You'll probably like this.
      #"immediate, class:^(American Truck Simulator)$"
    ];
  };
}
