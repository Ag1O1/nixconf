{inputs, ...}: {
  flake.modules = {
    nixos.mango = {
      programs.mango.enable = true;
      hj.imports = [
        inputs.self.modules.hjem.mango
      ];
    };
    hjem.mango = {
      lib,
      pkgs,
      ...
    }: let
    in {
      xdg.config.files."mango/config.conf".text = ''
        #############################
        # General
        #############################

        default_layout=scroller
        circle_layout=scroller,tile,monocle,grid

        gappih=5
        gappiv=5
        gappoh=5
        gappov=5

        sensitivity=0.5
        sloppyfocus=1

        repeat_rate=30
        repeat_delay=300
        xkb_rules_layout=us,eg

        trackpad_natural_scrolling=1


        #############################
        # Scroller
        #############################

        scroller_focus_center=1
        scroller_prefer_center=1
        scroller_default_proportion=0.8


        #############################
        # Blur
        #############################

        blur=1
        blur_optimized=1

        blur_params_num_passes=3
        blur_params_radius=5
        blur_params_noise=0.02
        blur_params_brightness=0.9
        blur_params_contrast=0.9
        blur_params_saturation=1.1


        #############################
        # Autostart
        #############################

        exec-once=noctalia


        #############################
        # Applications
        #############################

        bind=SUPER,q,spawn,ghostty
        bind=SUPER,p,spawn,/home/amr/.config/noctalia/hooks/performance-on.sh
        bind=SUPER+SHIFT,p,spawn,/home/amr/.config/noctalia/hooks/performance-off.sh

        bind=SUPER+SHIFT,c,killclient

        bind=SUPER,s,spawn,wlr-which-key
        bind=SUPER,w,spawn,helium
        bind=SUPER,e,spawn,yazi
        bind=SUPER,a,spawn,${lib.getExe pkgs.hyprmag} -r 2000


        #############################
        # Noctalia
        #############################

        bind=SUPER,g,spawn,noctalia msg panel-toggle control-center
        bind=SUPER,r,spawn,noctalia msg panel-toggle launcher
        bind=SUPER+CTRL,r,spawn,noctalia msg panel-toggle control-center
        bind=SUPER+SHIFT,r,spawn,noctalia msg panel-toggle clipboard


        #############################
        # Screenshots
        #############################

        bind=SUPER+SHIFT,s,spawn_shell,${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} --type image/png && notify-send "Screenshot copied to clipboard!"

        bind=SUPER+SHIFT+CTRL,s,spawn_shell,${lib.getExe' pkgs.wl-clipboard "wl-paste"} | ${lib.getExe pkgs.satty} --filename -

        bind=SUPER+SHIFT+ALT,s,spawn_shell,${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -o)" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} --type image/png && notify-send "Screenshoted window copied to clipboard!"


        #############################
        # XF86
        #############################

        bind=NONE,XF86AudioRaiseVolume,spawn,noctalia msg volume-up
        bind=NONE,XF86AudioLowerVolume,spawn,noctalia msg volume-down
        bind=NONE,XF86AudioMute,spawn,noctalia msg volume-mute
        bind=NONE,XF86AudioMicMute,spawn,noctalia msg mic-mute

        bind=NONE,XF86AudioNext,spawn,noctalia msg media next
        bind=NONE,XF86AudioPause,spawn,noctalia msg media toggle
        bind=NONE,XF86AudioPlay,spawn,noctalia msg media toggle
        bind=NONE,XF86AudioPrev,spawn,noctalia msg media previous

        bind=NONE,XF86MonBrightnessUp,spawn,noctalia msg brightness-up
        bind=NONE,XF86MonBrightnessDown,spawn,noctalia msg brightness-down


        #############################
        # Tags
        #############################

        bind=SUPER,1,view,1
        bind=SUPER,2,view,2
        bind=SUPER,3,view,3
        bind=SUPER,4,view,4
        bind=SUPER,5,view,5
        bind=SUPER,6,view,6
        bind=SUPER,7,view,7
        bind=SUPER,8,view,8
        bind=SUPER,9,view,9

        bind=SUPER+SHIFT,1,tag,1
        bind=SUPER+SHIFT,2,tag,2
        bind=SUPER+SHIFT,3,tag,3
        bind=SUPER+SHIFT,4,tag,4
        bind=SUPER+SHIFT,5,tag,5
        bind=SUPER+SHIFT,6,tag,6
        bind=SUPER+SHIFT,7,tag,7
        bind=SUPER+SHIFT,8,tag,8
        bind=SUPER+SHIFT,9,tag,9


        #############################
        # Adjacent Tags
        #############################

        bind=SUPER,d,viewtoleft
        bind=SUPER,c,viewtoright


        #############################
        # Focus
        #############################

        bind=SUPER,z,focusdir,left
        bind=SUPER,x,focusdir,right


        #############################
        # Layouts
        #############################

        # Cycle layouts
        bind=SUPER+SHIFT,TAB,switch_layout

        # Explicit layouts
        bind=SUPER+CTRL,1,setlayout,scroller
        bind=SUPER+CTRL,2,setlayout,tile
        bind=SUPER+CTRL,3,setlayout,monocle
        bind=SUPER+CTRL,4,setlayout,grid


        #############################
        # Scroller
        #############################

        bind=SUPER+ALT,e,set_proportion,1.0
        bind=SUPER+ALT,x,switch_proportion_preset


        #############################
        # Window States
        #############################

        bind=SUPER,f,togglemaximizescreen
        bind=SUPER+ALT,f,togglefullscreen
        bind=SUPER+SHIFT,f,togglefullscreen

        bind=SUPER,v,togglefloating


        #############################
        # Overview
        #############################

        bind=SUPER,TAB,toggleoverview


        #############################
        # Config / Session
        #############################

        bind=SUPER+SHIFT,o,reload_config
        bind=SUPER+SHIFT,DELETE,quit

        bind=SUPER,space,switch_keyboard_layout
      '';
    };
  };
}
