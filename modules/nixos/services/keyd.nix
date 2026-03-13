{
  flake.modules.nixos.keyd = {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
                     capslock = "overload(nav, esc)";
                     "\\" = "backspace";
                     backspace = "\\";
                   };
                   "shift:S" = {
                     capslock = "capslock";
                   };
                   "nav:C" = {
                     h = "left";
                     j = "down";
                     k = "up";
                     l = "right";
                     b = "C-left";
                     w = "C-right";
                     "0" = "home";
                     "4" = "end";
                     d = "layer(nav_delete)";
                     i = "pageup";
                     u = "pagedown";
                   };
                   nav_delete = {
                     w = "C-delete";
                     b = "C-backspace"; # Standardized for "word" delete
                   };
                 };
      };
    };
  };
}
