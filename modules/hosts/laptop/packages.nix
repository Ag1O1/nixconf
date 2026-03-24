{...}: {
  flake.modules.nixos.laptopPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      audacity
      obs-studio
      resources
      onlyoffice-desktopeditors
      qbittorrent-enhanced

      protonvpn-gui
      mpv
      gnome-calendar
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
      foot
      bibata-cursors
      noctalia-shell
    ];
    fonts.packages = with pkgs; [
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
  };
}
