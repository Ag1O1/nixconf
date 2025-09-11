{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tui.starship;
in {
  options.modules.programs.tui.starship = {
    enable = lib.mkEnableOption "starship";
  };
  config = mkIf cfg.enable {
    hj.rum.programs.starship = {
      enable = true;
      integrations = {
            fish.enable = true;
      };
      settings = {
        character = {
          success_symbol = "";
          error_symbol = "";
        };

        username = {
          style_user = "white";
          style_root = "black";
          format = "[$user]($style) ";
          show_always = true;
        };

        format = concatStrings [
          "[╭╴](238)$os"
          "$all[╰─󰁔](237)$character"
        ];

        directory = {
          truncation_length = 3;
          truncation_symbol = "…/";
          home_symbol = "󰋞 ";
          read_only_style = "197";
          read_only = "  ";
          format = "at [$path]($style)[$read_only]($read_only_style) ";

          substitutions = {
            "󰋞 /Documents" = "󰈙 ";
            "󰋞 /documents" = "󰈙 ";

            "󰋞 /Downloads" = " ";
            "󰋞 /downloads" = " ";

            "󰋞 /Music" = " ";
            "󰋞 /Pictures" = " ";
            "󰋞 /Videos" = " ";

            "󰋞 /Projects" = "󱌢 ";

            "󰋞 /.config" = " ";
          };
        };

        os = {
          style = "bold white";
          format = "[$symbol]($style)";

          symbols = {
            Arch = "";
            Artix = "";
            Debian = "";
            # Kali = "󰠥";
            EndeavourOS = "";
            Fedora = "";
            NixOS = "";
            openSUSE = "";
            SUSE = "";
            Ubuntu = "";
            Raspbian = "";
            #elementary = "";
            #Coreos = "";
            Gentoo = "";
            #mageia = ""
            CentOS = "";
            #sabayon = "";
            #slackware = "";
            Mint = "";
            Alpine = "";
            #aosc = "";
            #devuan = "";
            Manjaro = "";
            #rhel = "";
            Macos = "󰀵";
            Linux = "";
            Windows = "";
          };
        };

        git_branch = {
          symbol = "󰊢 ";
          format = "on [$symbol$branch]($style) ";
          truncation_length = 4;
          truncation_symbol = "…/";
          style = "bold green";
        };
        git_status = {
          format = "[\\($all_status$ahead_behind\\)]($style) ";
          style = "bold green";
          conflicted = "🏳";
          up_to_date = " ";
          untracked = " ";
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
          stashed = "󰏗 ";
          modified = " ";
          staged = "[++\\($count\\)](green)";
          renamed = "󰖷 ";
          deleted = " ";
        };

        nix_shell.symbol = " ";
      };
    };
  };
}
