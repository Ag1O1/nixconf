{inputs, ...}: {
  flake.modules.nixos.nix = {
    pkgs,
    lib,
    ...
  }: {
    nixpkgs.pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = ["electron-39.8.10"];
      };
      overlays = [inputs.nix-cachyos-kernel.overlays.pinned];
    };

    services.nix-daemon = {
      enable = true;
      settings = {
        substituters = ["https://attic.xuyh0120.win/lantian" "https://finix.cachix.org"];
        trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" "finix.cachix.org-1:0ejikHDeCp0UErsduUUHcg9IJczY2/h2e5132Z/As/c="];
        cores = 4;
        auto-optimise-store = true;
        experimental-features = "nix-command flakes"; # unverified — see note below
      };
    };

    environment.systemPackages = [
      pkgs.nix-search-tv
      pkgs.nixd
      pkgs.package-version-server
      pkgs.nil
      pkgs.nh # package only — see note on programs.nh below
    ];
  };
}
