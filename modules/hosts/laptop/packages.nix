{...}: {
  flake.modules.nixos.laptopPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      godot
      equibop
      blender
    ];
  };
}
