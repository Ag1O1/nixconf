{
  pkgs,
  lib,
  config,
  ...
}: let
  auto-start-script = import ./autostart.nix {inherit pkgs;};
  inherit (config.theme) fonts cursor;
  inherit (builtins) toString;
  inherit
    (config.modules.services.mime)
    browser
    terminal
    file-manager
    ;
in ''
  workspace "browser" {
      open-on-output "DP-1"
  }
  workspace "main" {
      open-on-output "DP-1"
  }
  workspace "chat" {
      open-on-output "DP-1"
  }

    input {
        focus-follows-mouse max-scroll-amount="10%"
      keyboard {
          xkb {

              layout "us,eg"

              options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"
              }
              repeat-delay 301
              repeat-rate 31
      }

      touchpad {
          tap
          natural-scroll
      }

      mouse {
           accel-speed -0.3
           accel-profile "flat"
      }
  }
  output "DP-1" {
    mode "1920x1080@60.000"
    focus-at-startup
    position x=0 y=0
  }
  output "DVI-D-1" {
    mode "1600x900@60.000"
    position x=1920 y=110
  }
  output "HDMI-A-1" {
    mode "1920x1080@60.000"
    position x=-300 y=300
  }
  layout {
      gaps 3
      //center-focused-column "on-overflow"
      default-column-width { proportion 0.5; }
      focus-ring {
          off
          width 2
          active-color " #5e4bb4 "
          inactive-color "#505050"
      }
      border {
          width 2
          active-color " #775117"
          inactive-color "#00165A"

           active-gradient from="#A5B9FF" to="#0D45C2" angle=140 relative-to="workspace-view"
           inactive-gradient from="#404040" to="#202020" angle=140 relative-to="workspace-view"
      }

      shadow {
          //on
          softness 30
          spread 5
          offset x=0 y=5
          color "#0007"
      }

      // Struts shrink the area occupied by windows, similarly to layer-shell panels.
      // You can think of them as a kind of outer gaps. They are set in logical pixels.
      // Left and right struts will cause the next window to the side to always be visible.
      // Top and bottom struts will simply add outer gaps in addition to the area occupied by
      // layer-shell panels and regular gaps.
      struts {
          // left 64
          // right 64
          // top 64
          // bottom 64
      }
  }

  spawn-at-startup "${lib.getExe auto-start-script}"
  spawn-at-startup "${browser}"
  cursor {
      xcursor-theme "${cursor.name}"
      xcursor-size ${toString cursor.size}
  }
  environment {
      PROTONPATH "GE-Proton"
      SSH_AUTH_SOCK "/home/amr/.bitwarden-ssh-agent.sock"
  }

  prefer-no-csd

  screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

  animations {
      // Uncomment to turn off all animations.
       //off

      // Slow down all animations by this factor. Values below 1 speed them up instead.
       slowdown 0.7
  }
  window-rule {
      // This regular expression is intentionally made as specific as possible,
      // since this is the default config, and we want no false positives.
      // You can get away with just app-id="wezterm" if you want.
      match app-id=r#"^org\.wezfurlong\.wezterm$"#
      default-column-width {}
  }

  // Open the Firefox picture-in-picture player as floating by default.
  window-rule {
      // This app-id regular expression will work for both:
      // - host Firefox (app-id is "firefox")
      // - Flatpak Firefox (app-id is "org.mozilla.firefox")
      match app-id=r#"firefox$"# title="^Picture-in-Picture$"
      match app-id="com.gabm.satty"
      open-floating true
  }

  // Example: block out two password managers from screen capture.
  // (This example rule is commented out with a "/-" in front.)
  window-rule {
      match app-id=r#"^org\.keepassxc\.KeePassXC$"#
      match app-id=r#"^org\.gnome\.World\.Secrets$"#
      match app-id="Bitwarden"
      match title="Bitwarden"

      block-out-from "screen-capture"

      // Use this instead if you want them visible on third-party screenshot tools.
      // block-out-from "screencast"
  }

  // Example: enable rounded corners for all windows.
  // (This example rule is commented out with a "/-" in front.)
  window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
  }
  window-rule {
      match title="Open File"
      match title="Open Folder"
      match app-id="Godot" title="Create New Node"
      match app-id="Godot" title="Project Settings"
      match app-id="Godot" title="Editor Settings"
      match app-id="Godot" title="Export"
      match app-id="Godot" title="Run Instances"
      match app-id="Godot" title="Attach Node Script"
      match app-id="Godot" title="Select Scene"
      match app-id="Godot" title="Event Configuration"
      match app-id="Godot" title="Save"
      match app-id="Godot" title="Please Confirm"
      match app-id="Godot" title="Pick Root Node Type"
      match app-id="org.kde.ark" title="Extracting"
      match app-id="org.gnome.Nautilus" title="Open"
      open-floating true
  }
  window-rule {
      match app-id="firefox-devedition" at-startup=true
      open-on-workspace "browser"
      open-maximized true
  }
  window-rule {
      match app-id="discord"
      match app-id="vesktop"
      open-on-workspace "chat"
      open-maximized true
  }
  layer-rule {
      match namespace="^wallpaper$"
      match namespace="^quickshell-overview$"
      place-within-backdrop true
  }
  layer-rule {
      match namespace="^launcher$"

      baba-is-float true
  }
  clipboard {
      disable-primary
  }
  hotkey-overlay {
      skip-at-startup
  }

  binds {
      Mod+Shift+Slash { show-hotkey-overlay; }

      // Suggested binds for running programs: terminal, app launcher, screen locker.
      Mod+Q { spawn "${terminal}"; }
      Mod+G { spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle"; }
      //Mod+Shift+Q { spawn "ghostty"; }
      //Mod+R { spawn "fuzzel" "--no-mouse"; }
      Mod+R {spawn-sh "noctalia-shell ipc call launcher toggle"; }
      Mod+B { spawn "noctalia-shell" "ipc" "call" "launcher" "clipboard"; }
      Super+Alt+L { spawn "noctalia-shell" "ipc" "call" "lockScreen" "toggle"; }
      Mod+W { spawn "${browser}"; }

      // You can also use a shell. Do this if you need pipes, multiple commands, etc.
      // Note: the entire command goes as a single argument in the end.
      // Mod+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }

      // Example volume keys mappings for PipeWire & WirePlumber.
      // The allow-when-locked=true property makes them work even when the session is locked.
      XF86AudioRaiseVolume allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "increase"; }
      XF86AudioLowerVolume allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "decrease"; }
      XF86AudioMute        allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "muteOutput"; }
      Mod+Alt+X     allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "muteInput"; }
      XF86Calculator     allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "launcher" "calculator"; }
      XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
      //XF86AudioStop allow-when-locked=true { spawn "playerctl" "stop"; }
      XF86AudioNext allow-when-locked=true { spawn "playerctl" "next";}
      XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }

      Mod+Shift+C { close-window; }

      Mod+Left  { focus-column-left; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }
      Mod+Right { focus-column-right; }
      Mod+C      { focus-workspace-down; }
      Mod+D      { focus-workspace-up; }
      Mod+Ctrl+Z { focus-monitor-left; }
      Mod+Ctrl+X { focus-monitor-right; }
      Mod+Z     { focus-column-left; }
      Mod+X     { focus-column-right; }
      Mod+H     { focus-column-left; }
      Mod+J     { focus-window-down; }
      Mod+K     { focus-window-up; }
      Mod+L     { focus-column-right; }
      Mod+E     { spawn "${file-manager}"; }
      Mod+Tab { toggle-overview; }

      Mod+Ctrl+Left  { move-column-left; }
      Mod+Ctrl+Down  { move-window-down; }
      Mod+Ctrl+Up    { move-window-up; }
      Mod+Ctrl+Right { move-column-right; }
      Mod+Ctrl+H     { move-column-left; }
      Mod+Ctrl+J     { move-window-down; }
      Mod+Ctrl+K     { move-window-up; }
      Mod+Ctrl+L     { move-column-right; }

      // Alternative commands that move across workspaces when reaching
      // the first or last window in a column.
      // Mod+J     { focus-window-or-workspace-down; }
      // Mod+K     { focus-window-or-workspace-up; }
      // Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
      // Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

      Mod+Home { focus-column-first; }
      Mod+End  { focus-column-last; }
      Mod+Ctrl+Home { move-column-to-first; }
      Mod+Ctrl+End  { move-column-to-last; }

      Mod+Shift+Left  { focus-monitor-left; }
      Mod+Shift+Down  { focus-monitor-down; }
      Mod+Shift+Up    { focus-monitor-up; }
      Mod+Shift+Right { focus-monitor-right; }
      Mod+Shift+H     { focus-monitor-left; }
      Mod+Shift+J     { focus-monitor-down; }
      Mod+Shift+K     { focus-monitor-up; }
      Mod+Shift+L     { focus-monitor-right; }

      Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

      // Alternatively, there are commands to move just a single window:
      // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
      // ...

      // And you can also move a whole workspace to another monitor:
      // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
      // ...

      Mod+Page_Down      { focus-workspace-down; }
      Mod+Page_Up        { focus-workspace-up; }
      Mod+U              { focus-workspace-down; }
      Mod+I              { focus-workspace-up; }
      Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
      Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
      Mod+Ctrl+U         { move-column-to-workspace-down; }
      Mod+Ctrl+I         { move-column-to-workspace-up; }

      // Alternatively, there are commands to move just a single window:
      // Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
      // ...

      Mod+Shift+Page_Down { move-workspace-down; }
      Mod+Shift+Page_Up   { move-workspace-up; }
      Mod+Shift+U         { move-workspace-down; }
      Mod+Shift+I         { move-workspace-up; }

      // You can bind mouse wheel scroll ticks using the following syntax.
      // These binds will change direction based on the natural-scroll setting.
      //
      // To avoid scrolling through workspaces really fast, you can use
      // the cooldown-ms property. The bind will be rate-limited to this value.
      // You can set a cooldown on any bind, but it's most useful for the wheel.
      Mod+WheelScrollDown      cooldown-ms=125 { focus-workspace-down; }
      Mod+WheelScrollUp        cooldown-ms=125 { focus-workspace-up; }
      Mod+Ctrl+WheelScrollDown cooldown-ms=125 { move-column-to-workspace-down; }
      Mod+Ctrl+WheelScrollUp   cooldown-ms=125 { move-column-to-workspace-up; }

      Mod+WheelScrollRight      { focus-column-right; }
      Mod+WheelScrollLeft       { focus-column-left; }
      Mod+Ctrl+WheelScrollRight { move-column-right; }
      Mod+Ctrl+WheelScrollLeft  { move-column-left; }

      // Usually scrolling up and down with Shift in applications results in
      // horizontal scrolling; these binds replicate that.
      Mod+Shift+WheelScrollDown      { focus-column-right; }
      Mod+Shift+WheelScrollUp        { focus-column-left; }
      Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
      Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

      // Similarly, you can bind touchpad scroll "ticks".
      // Touchpad scrolling is continuous, so for these binds it is split into
      // discrete intervals.
      // These binds are also affected by touchpad's natural-scroll, so these
      // example binds are "inverted", since we have natural-scroll enabled for
      // touchpads by default.
      // Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
      // Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

      // You can refer to workspaces by index. However, keep in mind that
      // niri is a dynamic workspace system, so these commands are kind of
      // "best effort". Trying to refer to a workspace index bigger than
      // the current workspace count will instead refer to the bottommost
      // (empty) workspace.
      //
      // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
      // will all refer to the 3rd workspace.
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      Mod+Ctrl+1 { move-column-to-workspace 1; }
      Mod+Ctrl+2 { move-column-to-workspace 2; }
      Mod+Ctrl+3 { move-column-to-workspace 3; }
      Mod+Ctrl+4 { move-column-to-workspace 4; }
      Mod+Ctrl+5 { move-column-to-workspace 5; }
      Mod+Ctrl+6 { move-column-to-workspace 6; }
      Mod+Ctrl+7 { move-column-to-workspace 7; }
      Mod+Ctrl+8 { move-column-to-workspace 8; }
      Mod+Ctrl+9 { move-column-to-workspace 9; }

      // Alternatively, there are commands to move just a single window:
      // Mod+Ctrl+1 { move-window-to-workspace 1; }

      // Switches focus between the current and the previous workspace.
      // Mod+Tab { focus-workspace-previous; }

      // The following binds move the focused window in and out of a column.
      // If the window is alone, they will consume it into the nearby column to the side.
      // If the window is already in a column, they will expel it out.
      Mod+BracketLeft  { consume-or-expel-window-left; }
      Mod+BracketRight { consume-or-expel-window-right; }

      // Consume one window from the right to the bottom of the focused column.
      Mod+Comma  { consume-window-into-column; }
      // Expel the bottom window from the focused column to the right.
      Mod+Period { expel-window-from-column; }

      //Mod+T { switch-preset-column-width; }
      //Mod+Shift+R { switch-preset-window-height; }
      //Mod+Ctrl+R { reset-window-height; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+Ctrl+F { toggle-windowed-fullscreen; }

      // Expand the focused column to space not taken up by other fully visible columns.
      // Makes the column "fill the rest of the space".
      //Mod+Ctrl+F { expand-column-to-available-width; }

      Mod+N { center-column; }

      // Finer width adjustments.
      // This command can also:
      // * set width in pixels: "1000"
      // * adjust width in pixels: "-5" or "+5"
      // * set width as a percentage of screen width: "25%"
      // * adjust width as a percentage of screen width: "-10%" or "+10%"
      // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
      // set-column-width "100" will make the column occupy 200 physical screen pixels.
      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }

      // Finer height adjustments when in column with other windows.
      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }


      // Move the focused window between the floating and the tiling layout.
      Mod+V       { toggle-window-floating; }
      Mod+Shift+V { switch-focus-between-floating-and-tiling; }

      // Toggle tabbed column display mode.
      // Windows in this column will appear as vertical tabs,
      // rather than stacked on top of each other.
      Mod+T { toggle-column-tabbed-display; }

      // Actions to switch layouts.
      // Note: if you uncomment these, make sure you do NOT have
      // a matching layout switch hotkey configured in xkb options above.
      // Having both at once on the same hotkey will break the switching,
      // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
      // Mod+Space       { switch-layout "next"; }
      // Mod+Shift+Space { switch-layout "prev"; }
      XF86Launch3 { screenshot; }
      Ctrl+XF86Launch3 { screenshot-screen; }
      Alt+XF86Launch3 { screenshot-window; }
      Shift+XF86Launch3 { spawn-sh "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image/png | ${lib.getExe' pkgs.satty "satty"} -f -"; }
      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }
      Shift+Print { spawn-sh "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image/png | ${lib.getExe' pkgs.satty "satty"} -f -"; }
      //Shift+Print { spawn-sh "${lib.getExe' pkgs.grim "grim"} -g \"$(${lib.getExe' pkgs.slurp "slurp"})\" - | ${lib.getExe' pkgs.satty "satty"} -f -"; }

      // Applications such as remote-desktop clients and software KVM switches may
      // request that niri stops processing the keyboard shortcuts defined here
      // so they may, for example, forward the key presses as-is to a remote machine.
      // It's a good idea to bind an escape hatch to toggle the inhibitor,
      // so a buggy application can't hold your session hostage.
      //
      // The allow-inhibiting=false property can be applied to other binds as well,
      // which ensures niri always processes them, even when an inhibitor is active.
      Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

      // The quit action will show a confirmation dialog to avoid accidental exits.
      Mod+Shift+E { quit; }
      Ctrl+Alt+Delete { quit; }

      // Powers off the monitors. To turn them back on, do any input like
      // moving the mouse or pressing any other key.
      Mod+Shift+P { power-off-monitors; }
      }
''
