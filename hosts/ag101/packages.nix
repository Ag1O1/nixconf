{
  pkgs,
  inputs,
  ...
}: let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  environment.systemPackages = [
    pkgs.galculator # Calculator
    pkgs.scarab # Hollow knight modder
    pkgs.ungoogled-chromium
    pkgs.element-desktop
    pkgs.thunderbird
    pkgs.r2modman
    pkgs.xp-pen-g430-driver
    pkgs.distrobox
    pkgs.cemu # wii u emulator
    pkgs.grayjay
    #pkgs.oneshot # for zeditor
    pkgs.bitwarden-desktop
    #pkgs.onlyoffice-desktopeditors
    pkgs.zed-editor
    pkgs.zed-discord-presence
    pkgs.waypaper
    pkgs.swaybg
    pkgs-stable.swww
    pkgs.playerctl
    pkgs.udiskie
    # cosmic apps currently broken (unresponsive)
    #pkgs.cosmic-edit
    #pkgs.cosmic-files
    pkgs.gthumb
    pkgs.zoxide
    pkgs.inkscape
    #pkgs.audacity fails to build

    pkgs.pkg-config
    pkgs.tree
    pkgs.wget
    pkgs.git
    pkgs.gh

    pkgs.unrar
    pkgs.mission-center
    #pkgs.azahar #Fail to build
    pkgs.godot
    #pkgs.godot-export-templates-bin

    (pkgs.blender.override {
      cudaSupport = true;
      waylandSupport = true;
    })

    pkgs.ryubing # ryujinx
    #pkgs.cbonsai
    pkgs.gimp3
    pkgs.nemo-with-extensions # file manager
    pkgs.pavucontrol
    pkgs.qbittorrent
    pkgs.kdePackages.ark
    #pkgs.fzf
    #pkgs.atuin
    pkgs.dust
    (pkgs.btop.override {cudaSupport = true;})
    pkgs.bat
    pkgs.tldr
    pkgs.eza
    #pkgs.uget # download manager
    #pkgs.scrcpy
    #pkgs.nixfmt-rfc-style
    pkgs.libreoffice
    pkgs.simple-scan
    #pkgs.gnome-calendar
    #pkgs.element-desktop
    pkgs.aseprite
    #pkgs.kdePackages.kdenlive
    #pkgs.uget-integrator
    pkgs.gparted
    pkgs.lzip
    #pkgs.python3
    #pkgs.krita
    #pkgs.jre8
    #pkgs.jdk8
    #pkgs.haxe
    #pkgs.rustc
    #pkgs.cargo
    #pkgs.gcc

    #pkgs.thunderbird
    pkgs.microfetch
    pkgs.obsidian
    pkgs.vlc
    pkgs.udiskie
    pkgs.gvfs
    pkgs.udisks
    pkgs.usbutils
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
