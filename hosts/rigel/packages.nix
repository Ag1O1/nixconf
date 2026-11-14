{
  pkgs,
  inputs,
  ...
}: {
  hj.packages = with pkgs; [
    inputs.cressida.packages.${pkgs.stdenv.hostPlatform.system}.default
    libreoffice
    open-scq30
    aseprite
    wlr-randr
    piper
    comma
    wl-mirror
    arduino-cli
    kdePackages.kdenlive
    gimp
    #audacity
    resources

    #rayburst
    #equibop
    btrfs-progs
    bitwarden-desktop
    godot
    blender
    foot
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
