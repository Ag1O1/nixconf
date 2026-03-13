{...}: {
  flake.modules.nixos.laptopPackages = { pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zed-editor
      btop
      firefox-bin
      nemo
      godot
      equibop
      blender
      ghostty
      bibata-cursors
      noctalia-shell
    ];
  };
}
