{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.theme) cursor;
in {
  config = lib.mkIf config.modules.wms.hyprland.enable {
    hj.rum.desktops.hyprland = {
      settings = {
        workspace = [
          "1,name:Browser,persistent:true"
          "2,name:main1,persistent:true"
          "3,name:main2,persistent:true"
          "4,name:Discord,persistent:true"
        ];
        monitor = [
          "HDMI-A-1, preferred, 0x0, 1"
          "DVI-D-1, preferred, auto-right, 1"
        ];
        "$terminal" = "foot";
        "$fileManager" = "nemo";
        "$browser" = "librewolf";
        #"$menu" = "ags -c ~/.config/ags/config.js & ags -t applauncher";
        "$menu" = "noctalia-shell ipc call launcher toggle";
        env = [
          "XCURSOR_SIZE,${toString cursor.size}"
          "HYPRCURSOR_SIZE,${toString cursor.size}"

          "HYPRCURSOR_THEME,${cursor.name}"
        ];
        misc = {
          force_default_wallpaper = -1;
          #focus_on_activate = true;
          disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        };
        input = {
          kb_layout = "us,eg";
          #kb_variant = ",qwerty";
          #kb_model =
          kb_options = "grp:win_space_toggle";
          #kb_rules =
          repeat_delay = 300;
          repeat_rate = 30;

          follow_mouse = 1;
          accel_profile = "flat";
          sensitivity = -0.3;

          touchpad = {
            natural_scroll = false;
          };
        };
        cursor = {
          no_hardware_cursors = false;
          use_cpu_buffer = true;
        };
      };
    };
  };
}
