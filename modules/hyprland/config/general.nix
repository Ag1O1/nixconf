{config, ...}: let
  inherit (config.theme) cursor;
in {
  hj.rum.programs.hyprland.settings = {
    monitor = [
      "HDMI-A-1, preferred, 0x0, 1"
      "DVI-D-1, preferred, auto-right, 1"
    ];
    "$terminal" = "foot";
    "$fileManager" = "nautilus";
    "$browser" = "firefox-developer-edition";
    #"$menu" = "ags -c ~/.config/ags/config.js & ags -t applauncher";
    "$menu" = "fuzzel";
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
    render = {
      explicit_sync = 0;
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

    gestures = {
      workspace_swipe = false;
    };
  };
}
