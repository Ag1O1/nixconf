{inputs, ...}: {
  persystem = {pkgs, ...}: {
    packages.myNeovim =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          (
            {pkgs, ...}: {
              config.vim = {
                theme.enable = true;
              };
            }
          )
        ];
      })
      .neovim;
  };
}
