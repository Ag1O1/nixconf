{...}: {
  flake.nixosModules.laptopPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      godot
      equibop
    ];
  };
}
