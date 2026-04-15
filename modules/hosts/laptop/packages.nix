{self, ...}: {
  flake.modules.nixos.laptopPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
      kdePackages.kdenlive
      zathura #PDF viewer
      qimgv #image viewer
      gimp
      audacity
      obs-studio
      resources
      onlyoffice-desktopeditors
      qbittorrent-enhanced

      proton-vpn
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
      netcat # for godot zed
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
