{
  pkgs,
  inputs,
  ...
}: {
  hj.packages = with pkgs; [
    aseprite
    gnused
    wlr-randr
    calibre
    piper
    gparted
    comma
    wl-mirror
    arduino
    arduino-cli
    arduino-ide
    inkscape
    rar
    ryubing
    kdePackages.kdenlive
    zathura #PDF viewer
    qimgv #image viewer
    gimp
    audacity
    resources
    onlyoffice-desktopeditors
    motrix-next

    proton-vpn
    mpv
    gnome-calendar
    equibop
    pavucontrol
    file-roller
    btrfs-progs
    bitwarden-desktop
    zed-editor
    btop
    (nemo-with-extensions.override {
      extensions = with pkgs; [nemo-fileroller];
    })
    godot
    blender
    foot
  ];
  fonts = {
    packages = with pkgs; [
      wineWow64Packages.fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      corefonts
      vista-fonts
      unifont
      cascadia-code
      fira-code
      fira-sans
      inter
      roboto-serif
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [];
        sansSerif = [];
        serif = [];
        emoji = [];
      };
    };
  };
}
