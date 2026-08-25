{inputs, ...}: {
  flake.modules.nixos.umbriel = {pkgs, ...}: {
    imports = [
      inputs.umbriel.nixosModules.default
    ];
    programs.umbriel = {
      enable = true;
      portalPackage = inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    /*
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    */
  };
  flake.modules.hjem.umbriel = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.umbriel.hjemModules.default
    ];
    programs.umbriel = {
      enable = true;
      settings = {
        layout.mode = "dwindle";
        general.autostart = ["noctalia"];
        layout.gap = 5;
        input = {
          touchpad = {
            natural_scroll = true;
            #accel_profile = "flat";
            #sensitivity = 0.3;
          };
          keyboard = {
            repeat_rate = 30;
            repeat_delay = 300;
            layout = "us,eg";
          };
        };
        keybinds = {
          "Mod+Shift+O" = "config-reload";
          "Mod+Shift+DELETE" = "session-quit";
          # Apps #
          "Mod+Q" = "spawn:ghostty";
          "Mod+P" = "spawn:/home/amr/.config/noctalia/hooks/performance-on.sh";
          "Mod+Shift+P" = "spawn:/home/amr/.config/noctalia/hooks/performance-off.sh";
          "Mod+Shift+C" = "window-close";
          "Mod+S" = "spawn:wlr-which-key";
          "Mod+W" = "spawn:helium";
          "Mod+E" = "spawn:yazi";
          "Mod+A" = "spawn:${lib.getExe pkgs.hyprmag} -r 2000";

          "Mod+G" = "spawn:noctalia msg panel-toggle control-center";
          "Mod+R" = "spawn:noctalia msg panel-toggle launcher";
          "Mod+CTRL+R" = "spawn:noctalia msg panel-toggle control-center";
          "Mod+Shift+R" = "spawn:noctalia msg panel-toggle clipboard";

          "Mod+Shift+S" = ''spawn:${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} --type image/png && notify-send "Screenshot copied to clipboard!"'';
          "Mod+Shift+Ctrl+S" = ''spawn:${lib.getExe' pkgs.wl-clipboard "wl-paste"} | ${lib.getExe pkgs.satty} --filename -'';
          "Mod+Shift+Alt+S" = ''spawn:${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -o)" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} --type image/png && notify-send "Screenshoted window copied to clipboard!"'';

          # XF86 Keys #
          "XF86AudioRaiseVolume" = "spawn:noctalia msg volume-up";
          "XF86AudioLowerVolume" = "spawn:noctalia msg volume-down";
          "XF86AudioMute" = "spawn:noctalia msg volume-mute";
          "XF86AudioMicMute" = "spawn:noctalia msg mic-mute";
          "XF86AudioNext" = "spawn:noctalia msg media next";
          "XF86AudioPause" = "spawn:noctalia msg media toggle";
          "XF86AudioPlay" = "spawn:noctalia msg media toggle";
          "XF86AudioPrev" = "spawn:noctalia msg media previous";
          "XF86MonBrightnessUp" = "spawn:noctalia msg brightness-up";
          "XF86MonBrightnessDown" = "spawn:noctalia msg brightness-down";
          # Workspaces #
          "Mod+1" = "workspace-switch:1";
          "Mod+2" = "workspace-switch:2";
          "Mod+3" = "workspace-switch:3";
          "Mod+4" = "workspace-switch:4";
          "Mod+5" = "workspace-switch:5";
          "Mod+6" = "workspace-switch:6";
          "Mod+7" = "workspace-switch:7";
          "Mod+8" = "workspace-switch:8";
          "Mod+9" = "workspace-switch:9";

          "Mod+Shift+1" = "window-move-to-workspace:1";
          "Mod+Shift+2" = "window-move-to-workspace:2";
          "Mod+Shift+3" = "window-move-to-workspace:3";
          "Mod+Shift+4" = "window-move-to-workspace:4";
          "Mod+Shift+5" = "window-move-to-workspace:5";
          "Mod+Shift+6" = "window-move-to-workspace:6";
          "Mod+Shift+7" = "window-move-to-workspace:7";
          "Mod+Shift+8" = "window-move-to-workspace:8";
          "Mod+Shift+9" = "window-move-to-workspace:9";

          "Mod+Z" = "window-focus-left";
          "Mod+X" = "window-focus-right";
          "Mod+D" = "workspace-previous";
          "Mod+C" = "workspace-next";

          "Mod+F" = "window-toggle-maximize";
          "Mod+ALT+F" = "window-toggle-maximize-to-edges";
          "Mod+Shift+F" = "window-toggle-fullscreen";
          "Mod+V" = "window-toggle-floating";
          "Mod+Shift+V" = "window-toggle-pinned";

          "Mod+TAB" = "overview-toggle";
        };
        appearance.blur = {
          enabled = true;
          optimized = true;
          passes = 3;
          radius = 5;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.1;
        };
      };
    };
  };
}
