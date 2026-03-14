{...}: {
  flake.modules.nixos.laptopPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      obs-studio
      equibop
      pavucontrol
      file-roller
      btrfs-progs
      bitwarden-desktop
      zapzap
      zed-editor
      zed-discord-presence
      btop
      nemo
      godot
      blender
      ghostty
      bibata-cursors
      noctalia-shell
    ];
    fonts.packages = with pkgs; [
      wineWow64Packages.fonts
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
  };
}
