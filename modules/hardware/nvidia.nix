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
        package = mkDefault (config.boot.kernelPackages.nvidiaPackages.bleeding_edge.overrideAttrs (old: {
          postFixup =
            (old.postFixup or "")
            + ''
              for orig in $bin/origBin/*; do
                f=$bin/bin/$(basename $orig)
                rp=$(patchelf --print-rpath $f); int=$(patchelf --print-interpreter $f)
                install -m755 $orig $f
                patchelf --set-rpath "$rp" $f
                patchelf --interpreter "$int" $f
              done
            '';
        }));
      };
    };
  };
}
