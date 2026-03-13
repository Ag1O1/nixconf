{...}: {
  flake.modules.nixos.laptopPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zapzap
      zed-editor
      btop
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
