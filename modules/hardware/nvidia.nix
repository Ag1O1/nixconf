{
  tags = ["nvidia"];
  module = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkDefault fakeHash;
  in {
    hardware = {
      graphics.enable = true;
      nvidia = {
        enable = true;
        modesetting.enable = true;
        kernelModule = mkDefault "open";
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.bleeding_edge;
      };
    };
  };
}
