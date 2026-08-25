{
  inputs,
  pkgs,
}: {
  flake.modules.nixos.umbriel = {
    imports = [
      inputs.umbriel.hjemModules.default
    ];
    programs.umbriel = {
      enable = true;
      settings = {
        general.autostart = ["noctalia"];
        layout.gap = 5;
        input.keyboard.layout = "us,eg";
        keybinds = {
          "Mod+Q" = "spawn:ghostty";
          "Mod+SHIFT+C" = "window-close";
          "Mod" = "spawn:noctalia msg panel-toggle launcher";
        };
      };
    };
  };
}
