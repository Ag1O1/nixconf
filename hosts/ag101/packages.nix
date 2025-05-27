{
  pkgs,
  inputs,
  ...
}:
{
  hj.packages = [
    pkgs.oneshot # for zeditor
    pkgs.alejandra # for zeditor
    pkgs.bitwarden-desktop
    pkgs.onlyoffice-desktopeditors
    pkgs.zed-editor
    pkgs.nil
    pkgs.waypaper
    pkgs.swaybg
    pkgs.swww
    inputs.umu.packages.x86_64-linux.umu-launcher
    pkgs.playerctl
    pkgs.udiskie
    pkgs.mako
    pkgs.xwayland-satellite
    # cosmic apps currently broken (unresponsive)
    #pkgs.cosmic-edit
    #pkgs.cosmic-files
    pkgs.gthumb
    pkgs.zoxide
    pkgs.inkscape
    pkgs.wl-screenrec
    pkgs.audacity

    pkgs.pkg-config
    pkgs.tree
    pkgs.vim
    pkgs.wget
    pkgs.git
    pkgs.gh
    pkgs.ngrok

    pkgs.unrar
    pkgs.mission-center
    pkgs.azahar
    pkgs.godot
    pkgs.godot-export-templates-bin

    (pkgs.blender.override {
      cudaSupport = true;
      waylandSupport = true;
    })

    pkgs.ryubing # ryujinx
    pkgs.slurp
    pkgs.grim
    pkgs.cbonsai
    pkgs.gimp3
    pkgs.kdePackages.wacomtablet
    pkgs.nautilus # file manager
    pkgs.pavucontrol
    pkgs.qbittorrent
    pkgs.libsForQt5.ark
    pkgs.telegram-desktop
    pkgs.bc
    pkgs.minesweep-rs
    pkgs.fzf
    pkgs.atuin
    pkgs.dust
    (pkgs.btop.override { cudaSupport = true; })
    pkgs.bat
    pkgs.tldr
    pkgs.eza
    pkgs.uget # download manager
    pkgs.scrcpy
    pkgs.nixfmt-rfc-style
    pkgs.libreoffice
    pkgs.simple-scan
    pkgs.gnome-calendar
    #pkgs.equibop
    pkgs.element-desktop
    pkgs.aseprite
    pkgs.kdePackages.kdenlive
    pkgs.zapzap
    pkgs.uget-integrator
    pkgs.gparted
    pkgs.lzip
    pkgs.python3
    pkgs.krita
    pkgs.jre8
    pkgs.jdk8
    pkgs.haxe
    pkgs.rustc
    pkgs.cargo
    pkgs.gcc
    pkgs.qalculate-gtk
    pkgs.libqalculate
    pkgs.zapzap

    pkgs.vscode
    pkgs.thunderbird
    pkgs.vesktop
    pkgs.google-chrome
    pkgs.microfetch
    pkgs.obsidian
    pkgs.prismlauncher
    pkgs.vlc
    pkgs.bun
    #pkgs.davinci-resolve
    pkgs.udiskie
    pkgs.gvfs
    pkgs.udisks
    pkgs.usbutils
    pkgs.libwacom
  ];
  fonts.packages = with pkgs; [
    wineWow64Packages.fonts
    corefonts
    vista-fonts
    unifont
    cascadia-code
    fira-code
    inter
    roboto-serif
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
