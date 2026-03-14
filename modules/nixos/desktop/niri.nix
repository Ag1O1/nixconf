{inputs, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = inputs.linuxmobile-pkgs.packages.${pkgs.system}.niri;
    };
    environment.systemPackages = [pkgs.xwayland-satellite];
  };
}
