let
  mkSystem = import ../system.nix;
in
  mkSystem {
    system = "x86_64-linux";
    modules = m: [
      ./hardware.nix
      ./machine.nix
      ./packages.nix

      # Hardware
      m.hardware.nvidia
      m.hardware.bluetooth

      # Programs
      m.programs.nix-search-tv
      m.programs.openrgb
      m.programs.gaming
      m.programs.logisim
      m.programs.tmux
      m.programs.lazygit
      m.programs.obs
      m.programs.ly
      m.programs.noctalia
      m.programs.yazi
      m.programs.helium
      m.programs.firefox

      # Services
      m.services.pipewire
      m.services.ssh
      m.services.flatpak
      m.services.printing
      m.services.keyd
      m.services.direnv
      m.services.evolution

      # Desktop
      m.desktop.umbriel
    ];
  }
