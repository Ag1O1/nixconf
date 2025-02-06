{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
  inherit (config.theme) cursor;
in {
  config = mkIf cfg.enable {
    hj.files = {
      ".config/hypr/hyprland.conf".text =
        ''

          ################
          ### MONITORS ###
          ################

          monitor = HDMI-A-1, preferred, 0x0, 1
          monitor = DVI-D-1, preferred, auto-right, 1


          ###################
          ### MY PROGRAMS ###
          ###################

          $terminal = foot
          $fileManager = nautilus
          $menu = fuzzel
          $browser = firefox-developer-edition


	  
          ### etc
          render {
            explicit_sync = 0
          }

          #################
          ### AUTOSTART ###
          #################

          exec-once = ags -c ~/.c
          exec-once = sleep 8 ; discord
          exec-once = ngrok http --url=goose-neat-sponge.ngrok-free.app 8080
          exec-once = hyprctl setcursor Bibata-Modern-Ice 24
          exec-once = ${lib.getExe' pkgs.hyprpaper "hyprpaper"}
          exec-once = $browser
          exec-once = cd /home/amr/projects/rust/discord-ollama && nix develop path:flake/#run
          exec-once = [workspace 3] zapzap
          exec-once = ${lib.getExe' pkgs.udiskie "udiskie"}
          exec-once = ${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit
          exec-once = ${lib.getExe' pkgs.wl-clipboard "wl-paste"} -t text --watch ${lib.getExe' pkgs.clipman "clipman"} store --no-persist


          #############################
          ### ENVIRONMENT VARIABLES ###
          #############################

          # See https://wiki.hyprland.org/Configuring/Environment-variables/

          env = XCURSOR_SIZE,${toString cursor.size}
          env = HYPRCURSOR_SIZE,${toString cursor.size}
          env = HYPRCURSOR_THEME,${cursor.name}


          #####################
          ### LOOK AND FEEL ###
          #####################

          # Refer to https://wiki.hyprland.org/Configuring/Variables/

          # https://wiki.hyprland.org/Configuring/Variables/#general
          general {

              gaps_in = 0
              gaps_out = 0

              border_size = 1

              # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
              col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
              col.inactive_border = rgba(595959aa)

              # Set to true enable resizing windows by clicking and dragging on borders and gaps
              resize_on_border = false

              # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
              allow_tearing = false

              layout = dwindle
          }

          # https://wiki.hyprland.org/Configuring/Variables/#decoration
          decoration {
              rounding = 0
              rounding_power = 0

              # Change transparency of focused and unfocused windows
              active_opacity = 1.0
              inactive_opacity = 1.0

              shadow {
                  enabled = false
                  range = 4
                  render_power = 3
                  color = rgba(1a1a1aee)
              }

              # https://wiki.hyprland.org/Configuring/Variables/#blur
              blur {
                  enabled = true
                  size = 3
                  passes = 1

                  vibrancy = 0.1696
              }
          }

          # https://wiki.hyprland.org/Configuring/Variables/#animations
          animations {
              enabled = false

              # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              bezier = easeOutQuint,0.23,1,0.32,1
              bezier = easeInOutCubic,0.65,0.05,0.36,1
              bezier = linear,0,0,1,1
              bezier = almostLinear,0.5,0.5,0.75,1.0
              bezier = quick,0.15,0,0.1,1

              animation = global, 1, 10, default
              animation = border, 1, 5.39, easeOutQuint
              animation = windows, 1, 4.79, easeOutQuint
              animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
              animation = windowsOut, 1, 1.49, linear, popin 87%
              animation = fadeIn, 1, 1.73, almostLinear
              animation = fadeOut, 1, 1.46, almostLinear
              animation = fade, 1, 3.03, quick
              animation = layers, 1, 3.81, easeOutQuint
              animation = layersIn, 1, 4, easeOutQuint, fade
              animation = layersOut, 1, 1.5, linear, fade
              animation = fadeLayersIn, 1, 1.79, almostLinear
              animation = fadeLayersOut, 1, 1.39, almostLinear
              animation = workspaces, 1, 1.94, almostLinear, fade
              animation = workspacesIn, 1, 1.21, almostLinear, fade
              animation = workspacesOut, 1, 1.94, almostLinear, fade
          }

          dwindle {
              pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true # You probably want this
          }

          master {
              new_status = master
          }

          misc {
              force_default_wallpaper = 0
              disable_hyprland_logo = false
          }


          #############
          ### INPUT ###
          #############

          # https://wiki.hyprland.org/Configuring/Variables/#input
          input {
              kb_layout = "us,eg"
              kb_options = "grp:win_space_toggle"
              repeat_delay = 300
              repeat_rate = 30

              follow_mouse = 1
              accel_profile = "flat"
              sensitivity = -0.3

              touchpad {
                  natural_scroll = false
              }
          }
          cursor {
            no_hardware_cursors = false
            use_cpu_buffer = true
          }

          # https://wiki.hyprland.org/Configuring/Variables/#gestures
          gestures {
              workspace_swipe = false
          }

          # Example per-device config
          # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
          device {
              name = epic-mouse-v1
              sensitivity = -0.5
          }


          ###################
          ### KEYBINDINGS ###
          ###################

          # See https://wiki.hyprland.org/Configuring/Keywords/
          $mainMod = SUPER " Windows " key as main modifier

          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = $mainMod, Q, exec, $terminal
          bind = $mainMod SHIFT, C, killactive,
          bind = $mainMod SHIFT, M, exit,
          bind = $mainMod, E, exec, $fileManager
          bind = $mainMod, F, togglefloating,
          bind = $mainMod, R, exec, $menu
          bind = $mainMod, P, pseudo, # dwindle
          bind = $mainMod, J, togglesplit, # dwindle

          bind = $mainMod SHIFT, F,fullscreen,
          bind = $mainMod ALT, F, fullscreenstate, -1 2
          bind = $mainMod, V, exec, ${lib.getExe' pkgs.clipman "clipman"} pick -t STDOUT | fuzzel --dmenu | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}
          bind = ,Print, exec, ${lib.getExe pkgs.grimblast} --freeze copy area
          bind = SHIFT, Print, exec , ${lib.getExe pkgs.grimblast} --freeze save area - | ${lib.getExe pkgs.satty} -f -

          bind = $mainMod, S, togglespecialworkspace, magic
          bind = $mainMod SHIFT, S, movetoworkspace, special:magic
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          # Switch workspaces with mainMod + [0-9]
          bind = ALT, 1, workspace, 1
          bind = ALT, 2, workspace, 2
          bind = ALT, 3, workspace, 3
          bind = ALT, 4, workspace, 4
          bind = ALT, 5, workspace, 5
          bind = ALT, 6, workspace, 6
          bind = ALT, 7, workspace, 7
          bind = ALT, 8, workspace, 8
          bind = ALT, 9, workspace, 9
          bind = ALT, 0, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = ALT SHIFT, 1, movetoworkspace, 1
          bind = ALT SHIFT, 2, movetoworkspace, 2
          bind = ALT SHIFT, 3, movetoworkspace, 3
          bind = ALT SHIFT, 4, movetoworkspace, 4
          bind = ALT SHIFT, 5, movetoworkspace, 5
          bind = ALT SHIFT, 6, movetoworkspace, 6
          bind = ALT SHIFT, 7, movetoworkspace, 7
          bind = ALT SHIFT, 8, movetoworkspace, 8
          bind = ALT SHIFT, 9, movetoworkspace, 9
          bind = ALT SHIFT, 0, movetoworkspace, 10

          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow

          bindel = ,XF86AudioRaiseVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bindel = $mainMod,KP_Home, exec, hyprctl keyword cursor:use_cpu_buffer 0
          bindel = $mainMod,KP_Up, exec, hyprctl keyword cursor:use_cpu_buffer 1

          bindel = ,XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause
          bindel = ,XF86AudioStop, exec, ${lib.getExe pkgs.playerctl} Stop
          bindel = ,XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next
          bindel = ,XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous

          ##############################
          ### WINDOWS AND WORKSPACES ###
          ##############################

          windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
          windowrulev2 = noborder, onworkspace:w[t1]
          windowrulev2 = workspace 4 silent,class:^(discord)$
          windowrulev2 = float, class:^(org.gnome.Nautilus)$
          windowrulev2 = float, class:^(explorer.exe)$
        '';

    };
  };
}
