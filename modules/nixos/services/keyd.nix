{
  flake.modules.nixos.keyd = {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "layerm(nav, macro(esc+15ms))";
            "\\" = "backspace";
            backspace = "\\";
          };
          "shift:S" = {
            capslock = "capslock";
          };
          "nav" = {
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
            "\\" = "C-backspace";

            # Cheaty macros for games
            p = "macro(leftmouse+15ms)";
            "[" = "macro(esc 5ms leftmouse+15ms 5ms esc)";
            "]" = "macro(esc 5ms rightmouse+15ms 5ms esc)";
          };
          nav_delete = {
            w = "C-delete";
            b = "C-backspace";
          };
        };
      };
    };
  };
}
