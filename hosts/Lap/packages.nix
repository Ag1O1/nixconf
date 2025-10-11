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
    pkgs.zoom-us
    pkgs.resources
    pkgs.ghostty
    pkgs.zapzap # Whatsapp client
    pkgs.galculator # Calculator
    pkgs.ungoogled-chromium
    pkgs.bitwarden-desktop
    pkgs.zed-editor
    pkgs.zed-discord-presence
    pkgs.playerctl
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
    pkgs.godot

/*
    (pkgs.blender.override {
      cudaSupport = true;
      waylandSupport = true;
    })
    */

    #pkgs.gimp3
    pkgs.nemo-with-extensions # file manager
    pkgs.pavucontrol
    #pkgs.qbittorrent
    pkgs.kdePackages.ark

    pkgs.dust
    (pkgs.btop.override {cudaSupport = true;})
    pkgs.bat
    pkgs.eza
    pkgs-stable.libreoffice
    pkgs.simple-scan

    pkgs.gparted
    pkgs.lzip

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
