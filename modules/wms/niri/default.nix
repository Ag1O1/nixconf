{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.wms.niri;
  niri-config = import ./config.nix { inherit pkgs lib config; };
in
{
  #imports = [
  #  inputs.niri.nixosModules.niri
  #  inputs.niri.lib.internal.settings-module
  #];

  options.modules.wms.niri = {
    enable = lib.mkEnableOption "niri wm";
  };

  config = lib.mkIf cfg.enable {
    programs.xwayland.enable = lib.mkForce true;
    programs.niri = {
      enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    nix.settings = {
      extra-substituters = [
        "https://niri.cachix.org"
      ];
    };
    #programs.niri.package = inputs.niri.packages.niri;
    hj = {
      files = {
        ".config/niri/config.kdl".text = niri-config;
      };
    };

    #currently not possible to use the niri flake without home manager
    /*
      programs.niri = {
      enable = true;
      #package = pkgs.niri-unstable;

      settings = {
        hotkey-overlay.skip-at-startup = true;
        spawn-at-startup = auto-start-script;
        input = {
          focus-follows-mouse.max-scroll-amount = "10%";
          keyboard = {
            xkb = {
              layout = "us,eg";

              options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
            };
            repeat-delay = 301;
            repeat-rate = 31;
          };
          touchpad.enable = false;
          mouse = {
            accel-speed = -0.2;
            accel-profile = "flat";
          };
        };
        outputs = {
          "HDMI-A-1" = {
            enable = true;
            mode = "1920x1080@60.000";
            transform = "normal";
          };
        };
        layout = {
          gaps = 7;
          center-focused-column = "on-overflow";
          always-center-single-column = true;
          default-column-width.proportion = 0.5;
          focus-ring.enable = false;
          border = {
            width = 5;
            active-color = "#5e4bb4";
            inactive-color = "#505050";

            active-gradient = {
              from = "#4853C7";
              to = "#39338B";
              angle = 140;
              relative-to = "workspace-view";
            };
            inactive-gradient = {
              from = "#505050";
              to = "#808080";
              angle = 140;
              relative-to = "workspace-view";
            };
          };
        };
        animations = {
          enable = true;
        };
        window-rule = {
          geometry-corner-radius = 12;
          clip-to-geometry = true;
        };
        environment = {
          DISPLAY = ":0";
          PROTONPATH = "GE-Proton";
          GAMEID = "0";
        };
        binds = with config.home-manager.users.USER.lib.niri.actions; {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          "Mod+Q".action = spawn "foot";
          "Mod+R".action = spawn "fuzzel";
          "Super+Alt+L".action = spawn "swaylock";
          "Mod+W".action = spawn "firefox-developer-edition";

          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+";
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-";
          "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "XF86AudioPlay allow-when-locked=true".action = spawn "playerctl" "play-pause";
          "XF86AudioStop allow-when-locked=true".action = spawn "playerctl" "stop";
          "XF86AudioNext allow-when-locked=true".action = spawn "playerctl" "next";
          "XF86AudioPrev allow-when-locked=true".action = spawn "playerctl" "previous";

          "Mod+Shift+C".action = close-window;

          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+Z".action = focus-column-left;
          "Mod+X".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;
          "Mod+E".action = spawn "cosmic-files";

          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;

          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;

          "Mod+Shift+Left".action = focus-monitor-left;
          "Mod+Shift+Down".action = focus-monitor-down;
          "Mod+Shift+Up".action = focus-monitor-up;
          "Mod+Shift+Right".action = focus-monitor-right;
          "Mod+Shift+H".action = focus-monitor-left;
          "Mod+Shift+J".action = focus-monitor-down;
          "Mod+Shift+K".action = focus-monitor-up;
          "Mod+Shift+L".action = focus-monitor-right;

          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-column-to-workspace-down;
          "Mod+Ctrl+I".action = move-column-to-workspace-up;

          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;
          "Mod+Shift+U".action = move-workspace-down;
          "Mod+Shift+I".action = move-workspace-up;

          "Mod+WheelScrollDown".action = focus-workspace-down;
          "Mod+WheelScrollUp".action = focus-workspace-up;
          "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
          "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;

          "Mod+WheelScrollRight".action = focus-column-right;
          "Mod+WheelScrollLeft".action = focus-column-left;
          "Mod+Ctrl+WheelScrollRight".action = move-column-right;
          "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

          "Mod+Shift+WheelScrollDown".action = focus-column-right;
          "Mod+Shift+WheelScrollUp".action = focus-column-left;
          "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Ctrl+1".action = move-column-to-workspace 1;
          "Mod+Ctrl+2".action = move-column-to-workspace 2;
          "Mod+Ctrl+3".action = move-column-to-workspace 3;
          "Mod+Ctrl+4".action = move-column-to-workspace 4;
          "Mod+Ctrl+5".action = move-column-to-workspace 5;
          "Mod+Ctrl+6".action = move-column-to-workspace 6;
          "Mod+Ctrl+7".action = move-column-to-workspace 7;
          "Mod+Ctrl+8".action = move-column-to-workspace 8;
          "Mod+Ctrl+9".action = move-column-to-workspace 9;

          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;

          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+F".action = expand-column-to-available-width;

          "Mod+C".action = center-column;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";

          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

          "Mod+T".action = toggle-column-tabbed-display;

          "Print".action = screenshot;
          "Ctrl+Print".action = screenshot-screen;
          "Alt+Print".action = screenshot-window;

          "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

          "Mod+Shift+E".action = quit;
          "Ctrl+Alt+Delete".action = quit;

          "Mod+Shift+P".action = power-off-monitors;
          prefer-no-csd = true;
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          };
        };
        };
    */
  };
}
