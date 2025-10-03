{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.modules.wms.hyprland.enable {
    hj.rum.desktops.hyprland.settings = {
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
      bind =
        [
          "$mainMod, Q, exec, $terminal"
          "$mainMod SHIFT, C, killactive,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, W, exec, $browser"
          "$mainMod, V, togglefloating,"
          "$mainMod SHIFT, F,fullscreen,"
          "$mainMod ALT, F, fullscreenstate, -1 2"
          "$mainMod, R, exec, $menu"
          "$mainMod SHIFT, V, exec, noctalia-shell ipc call launcher clipboard"
          "$mainMod, C, exec, noctalia-shell ipc call launcher calculator"
          "$mainMod, DEL, exec, noctalia-shell ipc call lockScreen toggle"
          "$mainMod, P, pseudo, "
          "$mainMod, M, togglesplit, "

          ",Print, exec, ${lib.getExe pkgs.grimblast} --freeze copy area"
          "SHIFT, Print, exec , ${lib.getExe pkgs.grimblast} --freeze save area - | ${lib.getExe pkgs.satty} -f -"

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod , I, togglespecialworkspace"
          "$mainMod SHIFT, I, movetoworkspacesilent, special"
          "$mainMod, mouse_down, workspace, e-1"
          "$mainMod, mouse_up, workspace, e+1"

          "$mainMod , I, togglespecialworkspace"
          "$mainMod SHIFT, I, movetoworkspacesilent, special"
          "$mainMod,KP_Home, exec, hyprctl keyword cursor:use_cpu_buffer 0"
          "$mainMod,KP_Up, exec, hyprctl keyword cursor:use_cpu_buffer 1"
          "$mainMod,X,workspace,e+1"
          "$mainMod SHIFT,X,movetoworkspace,e+1"
          "$mainMod ALT,X,movetoworkspacesilent,e+1"
          "$mainMod,Z,workspace,e-1"
          "$mainMod SHIFT,Z,movetoworkspace,e-1"
          "$mainMod ALT,Z,movetoworkspacesilent,e-1"
        ]
        /*
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "ALT, code:1${toString i}, split-workspace, ${toString ws}"
                "ALT SHIFT, code:1${toString i}, split-movetoworkspace, ${toString ws}"
              ]
            )
            9)
        )
        */
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9
          )
        );
      /*
      plugin = {
        split-monitor-workspaces = {
          count = 10;
          keep_focused = 0;
          enable_notifications = 0;
          enable_persistent_workspaces = 0;
        };
      };
      */
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
        ",XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
        ",XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
        ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
        ",XF86AudioStop, exec, ${lib.getExe pkgs.playerctl} Stop"
        ",XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
        ",XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
        #",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
