{
  tags = ["rigel"];
  module = {
    fm,
    pkgs,
    lib,
    ...
  }: let
    mkScript = name: pkgs.writeShellScript name (builtins.readFile ./scripts/${name});
    fileNames = builtins.attrNames (builtins.readDir ./scripts);
    scripts = builtins.listToAttrs (map (name: {
        name = lib.removeSuffix ".sh" name;
        value = mkScript name;
      })
      fileNames);
  in {
    imports = [fm.mango];
    programs.mango.enable = true;
    hj = {
      xdg.config.files."mango/config.conf".text =
        #toml
        ''
          ### General ###

          circle_layout=scroller,dwindle,grid

          no_border_when_single = 1
          no_radius_when_single = 1
          smartgaps = 1
          borderpx=2
          border_radius=3
          gappih=3
          gappiv=3
          gappoh=3
          gappov=3

          sloppyfocus=1

          repeat_rate=30
          repeat_delay=300
          xkb_rules_layout=us,eg

          trackpad_natural_scrolling=1

          ### Mouse ###

          trackpad_accel_profile = 1
          trackpad_accel_speed = 1

          mouse_accel_profile = 1
          mouse_accel_speed = 0.1

          ### Scroller ###

          scroller_focus_center=1
          scroller_prefer_center=1
          scroller_default_proportion=0.8


          ### Blur ###

          blur=1
          blur_optimized=1
          blur_layer=0 # Broken with noctalia

          blur_params_num_passes=3
          blur_params_radius=5
          blur_params_noise=0.02
          blur_params_brightness=0.9
          blur_params_contrast=0.9
          blur_params_saturation=1.1


          ### Autostart ###

          exec-once=unset XDG_SESSION_ID && noctalia -d
          exec-once=pipewire
          exec-once=pipewire-pulse
          exec-once=sleep 1 && wireplumber


          ### Environment ###

          cursor_theme=Bibata-Modern-Ice
          cursor_size=24
          env=XCURSOR_THEME,Bibata-Modern-Ice
          env=XCURSOR_SIZE,24
          env=PROTONPATH,GE-Proton
          env=SSH_AUTH_SOCK,/home/amr/.bitwarden-ssh-agent.sock
          env=ELECTRON_OZONE_PLATFORM_HINT,auto
          env=QT_QPA_PLATFORMTHEME,qt6ct
          env=QT_QPA_PLATFORM,wayland
          env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1

          ### Applications ###

          bind=SUPER,q,spawn,foot
          bind=SUPER,t,spawn,foot -e ${scripts.todo}
          bind=SUPER,p,spawn,/home/amr/.config/noctalia/hooks/performance-on.sh
          bind=SUPER+SHIFT,p,spawn,/home/amr/.config/noctalia/hooks/performance-off.sh

          bind=SUPER+SHIFT,c,killclient

          bind=SUPER,s,spawn,${lib.getExe pkgs.wlr-which-key}
          bind=SUPER,w,spawn,librewolf
          bind=SUPER,e,spawn,foot -e yazi
          bind=SUPER,a,spawn,${lib.getExe pkgs.hyprmag} -r 2500


          ### Noctalia ###

          bind=SUPER,g,spawn,noctalia msg panel-toggle control-center
          bind=SUPER,r,spawn,noctalia msg panel-toggle launcher
          bind=SUPER+CTRL,r,spawn,noctalia msg panel-toggle control-center
          bind=SUPER+SHIFT,r,spawn,noctalia msg panel-toggle clipboard


          ### Screenshots ###

          bind=Super+SHIFT,S,spawn,noctalia msg screenshot-region
          bind=Super+SHIFT+ALT,S,spawn,noctalia msg screenshot-fullscreen
          bind=Super+CTRL,S,spawn,noctalia msg annotate


          ### XF86 ###

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


          ### Tags ###

          tagrule=id:1,layout_name:scroller
          tagrule=id:2,layout_name:scroller
          tagrule=id:3,layout_name:scroller
          tagrule=id:4,layout_name:scroller
          tagrule=id:5,layout_name:scroller
          tagrule=id:6,layout_name:scroller
          tagrule=id:7,layout_name:scroller
          tagrule=id:8,layout_name:scroller
          tagrule=id:9,layout_name:scroller

          bind=SUPER,1,comboview,1
          bind=SUPER,2,comboview,2
          bind=SUPER,3,comboview,3
          bind=SUPER,4,comboview,4
          bind=SUPER,5,comboview,5
          bind=SUPER,6,comboview,6
          bind=SUPER,7,comboview,7
          bind=SUPER,8,comboview,8
          bind=SUPER,9,comboview,9

          bind=SUPER+SHIFT,1,tag,1
          bind=SUPER+SHIFT,2,tag,2
          bind=SUPER+SHIFT,3,tag,3
          bind=SUPER+SHIFT,4,tag,4
          bind=SUPER+SHIFT,5,tag,5
          bind=SUPER+SHIFT,6,tag,6
          bind=SUPER+SHIFT,7,tag,7
          bind=SUPER+SHIFT,8,tag,8
          bind=SUPER+SHIFT,9,tag,9

          bind=SUPER+CTRL+SHIFT,1,toggletag,1
          bind=SUPER+CTRL+SHIFT,2,toggletag,2
          bind=SUPER+CTRL+SHIFT,3,toggletag,3
          bind=SUPER+CTRL+SHIFT,4,toggletag,4
          bind=SUPER+CTRL+SHIFT,5,toggletag,5
          bind=SUPER+CTRL+SHIFT,6,toggletag,6
          bind=SUPER+CTRL+SHIFT,7,toggletag,7
          bind=SUPER+CTRL+SHIFT,8,toggletag,8
          bind=SUPER+CTRL+SHIFT,9,toggletag,9

          ### Focus ###

          mousebind=SUPER,btn_left,moveresize,curmove
          mousebind=SUPER,btn_right,moveresize,curresize
          bind=SUPER,z,focusdir,left
          bind=SUPER,x,focusdir,right
          bind=SUPER,d,focusdir,up
          bind=SUPER,c,focusdir,down

          bind=SUPER,TAB,switcher,all_tag_next
          bind=SUPER+SHIFT,TAB,switcher,all_tag_prev
          bind=SUPER+CTRL,TAB,toggleoverview


          ### Layouts ###

          # Cycle layouts
          bind=SUPER+ALT,TAB,switch_layout

          # Explicit layouts
          bind=SUPER+CTRL,1,setlayout,scroller
          bind=SUPER+CTRL,2,setlayout,dwindle
          bind=SUPER+CTRL,3,setlayout,grid
          bind=SUPER+CTRL,4,setlayout,monocle

          ### Window States ###

          bind=SUPER,f,togglemaximizescreen
          bind=SUPER+SHIFT,f,togglefullscreen

          bind=SUPER,v,togglefloating


          ### Config / Session ###

          bind=SUPER+SHIFT,o,reload_config
          bind=SUPER+SHIFT,DELETE,quit

          bind=SUPER,space,switch_keyboard_layout

          ### sources ###
          source=~/.config/mango/noctalia.conf
        '';
    };
  };
}
