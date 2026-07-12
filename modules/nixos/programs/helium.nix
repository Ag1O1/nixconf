{inputs, ...}: {
  flake.modules.nixos.helium = {
    imports = [inputs.helium-flake.nixosModules.default];
    programs.helium = {
      enable = true;

      flags = [
        "--disable-gpu"
        "--ozone-platform-hint=auto"
      ];

      policies = {
        "BrowserSignin" = 0;
        "PasswordManagerEnabled" = false;
        "SyncDisabled" = true;
        "DefaultSearchProviderEnabled" = true;
        "DefaultSearchProviderSearchURL" = "http://localhost:8081/search?q={searchTerms}";
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = ["en-US"];
      };
    };
  };
}
