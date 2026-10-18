{
  pkgs,
  inputs,
  ...
}: {
  hj.packages = with pkgs; [
    libreoffice
    concord-tui
    aseprite
    gnused # for scripts
    wlr-randr
    piper
    comma
    wl-mirror
    arduino-cli
    kdePackages.kdenlive
    gimp
    audacity
    resources

    rayburst

    proton-vpn
    gnome-calendar
    equibop
    btrfs-progs
    bitwarden-desktop
    zed-editor
    godot
    blender
    foot
    ghostty
  ];
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      cascadia-code
      inter
      roboto-serif
      fira-code
      corefonts
      vista-fonts
      unifont
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Cascadia Code"];
        sansSerif = ["Inter"];
        serif = ["Roboto Serif"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
