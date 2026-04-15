{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myNeovim =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          (
            {pkgs, ...}: {
              config.vim = {
                viAlias = true;
                vimAlias = true;
                debugMode = {
                  enable = false;
                  level = 16;
                  logFile = "/tmp/nvim.log";
                };

                # vim.opts and vim.options are aliased
                opts.expandtab = true;

                lsp = {
                  # This must be enabled for the language modules to hook into
                  # the LSP API.
                  enable = true;

                  formatOnSave = true;
                  lspkind.enable = false;
                  lightbulb.enable = true;
                  lspsaga.enable = false;
                  trouble.enable = true;
                  otter-nvim.enable = true;
                };

                debugger = {
                  nvim-dap = {
                    enable = true;
                    ui.enable = true;
                  };
                };

                # This section does not include a comprehensive list of available language modules.
                # To list all available language module options, please visit the nvf manual.
                languages = {
                  enableFormat = true;
                  enableTreesitter = true;
                  enableExtraDiagnostics = true;

                  # Languages that will be supported in default and maximal configurations.
                  nix.enable = true;
                  markdown.enable = true;

                  # Languages that are enabled in the maximal configuration.
                  bash.enable = true;
                  clang.enable = true;
                  cmake.enable = true;
                  css.enable = true;
                  html.enable = true;
                  json.enable = true;
                  sql.enable = true;
                  java.enable = true;
                  kotlin.enable = true;
                  ts.enable = true;
                  go.enable = true;
                  lua.enable = true;
                  zig.enable = true;
                  python.enable = true;
                  typst.enable = true;
                  rust = {
                    enable = true;
                    extensions.crates-nvim.enable = true;
                  };
                  toml.enable = true;

                  # Language modules that are not as common.
                  openscad.enable = false;
                  arduino.enable = false;
                  assembly.enable = false;
                  astro.enable = false;
                  nu.enable = false;
                  csharp.enable = false;
                  julia.enable = false;
                  vala.enable = false;
                  scala.enable = false;
                  r.enable = false;
                  gleam.enable = false;
                  glsl.enable = false;
                  dart.enable = false;
                  ocaml.enable = false;
                  elixir.enable = false;
                  haskell.enable = false;
                  hcl.enable = false;
                  ruby.enable = false;
                  fsharp.enable = false;
                  just.enable = false;
                  make.enable = false;
                  qml.enable = false;
                  jinja.enable = false;
                  tailwind.enable = false;
                  svelte.enable = false;
                  liquid.enable = false;
                  tera.enable = false;
                  twig.enable = false;
                  gettext.enable = false;
                  fluent.enable = false;
                  jq.enable = false;
                  nim.enable = false;
                };

                visuals = {
                  nvim-scrollbar.enable = true;
                  nvim-web-devicons.enable = true;
                  nvim-cursorline.enable = true;
                  cinnamon-nvim.enable = true;
                  fidget-nvim.enable = true;

                  highlight-undo.enable = true;
                  blink-indent.enable = true;
                  indent-blankline.enable = true;

                  # Fun
                  cellular-automaton.enable = false;
                };

                statusline = {
                  lualine = {
                    enable = true;
                    theme = "catppuccin";
                  };
                };

                theme = {
                  enable = true;
                  name = "catppuccin";
                  style = "mocha";
                  transparent = false;
                };

                autopairs.nvim-autopairs.enable = true;

                # nvf provides various autocomplete options. The tried and tested nvim-cmp
                # is enabled in default package, because it does not trigger a build. We
                # enable blink-cmp in maximal because it needs to build its rust fuzzy
                # matcher library.
                autocomplete = {
                  blink-cmp.enable = true;
                };

                snippets.luasnip.enable = true;

                filetree = {
                  neo-tree = {
                    enable = true;
                  };
                };

                tabline = {
                  nvimBufferline.enable = true;
                };

                treesitter.context.enable = true;

                binds = {
                  whichKey.enable = true;
                  cheatsheet.enable = true;
                };

                telescope.enable = true;

                git = {
                  enable = true;
                  gitsigns.enable = true;
                  gitsigns.codeActions.enable = false; # throws an annoying debug message
                  neogit.enable = true;
                };

                minimap = {
                  minimap-vim.enable = false;
                  codewindow.enable = true; # lighter, faster, and uses lua for configuration
                };

                dashboard = {
                  dashboard-nvim.enable = false;
                  alpha.enable = true;
                };

                notify = {
                  nvim-notify.enable = true;
                };

                projects = {
                  project-nvim.enable = true;
                };

                utility = {
                  ccc.enable = false;
                  vim-wakatime.enable = false;
                  diffview-nvim.enable = true;
                  yanky-nvim.enable = false;
                  qmk-nvim.enable = false; # requires hardware specific options
                  icon-picker.enable = false;

                  motion = {
                    hop.enable = true;
                    leap.enable = true;
                  };
                  images = {
                    image-nvim.enable = false;
                    img-clip.enable = true;
                  };
                };

                notes = {
                  #neorg.enable = true;
                  #orgmode.enable = true;
                  mind-nvim.enable = true;
                  todo-comments.enable = true;
                };

                terminal = {
                  toggleterm = {
                    enable = true;
                    lazygit.enable = true;
                  };
                };

                ui = {
                  borders.enable = true;
                  noice.enable = true;
                  colorizer.enable = true;
                  modes-nvim.enable = false; # the theme looks terrible with catppuccin
                  illuminate.enable = true;
                  /*
                  breadcrumbs = {
                    enable = isMaximal;
                    navbuddy.enable = isMaximal;
                  };
                  */
                  smartcolumn = {
                    enable = true;
                    setupOpts.custom_colorcolumn = {
                      # this is a freeform module, it's `buftype = int;` for configuring column position
                      nix = "110";
                      ruby = "120";
                      java = "130";
                      go = ["90" "130"];
                    };
                  };
                  fastaction.enable = true;
                };

                session = {
                  nvim-session-manager.enable = false;
                };

                gestures = {
                  gesture-nvim.enable = false;
                };

                comments = {
                  comment-nvim.enable = true;
                };

                presence = {
                  neocord.enable = true;
                };
              };
            }
          )
        ];
      })
      .neovim;
  };
}
