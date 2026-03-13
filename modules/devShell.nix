{...}: {
  perSystem = {pkgs,...}: {
    devShells.default = pkgs.mkShell {
      packages = [pkgs.nil pkgs.nixd pkgs.alejandra];
    };
  };
}
