{
  flake.modules.nixos.firefox = {pkgs, ...}: {
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
    };
  };
}
