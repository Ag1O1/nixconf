{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.greetd;
  username = "amr";
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  options.modules.system.greetd = {
    enable = lib.mkEnableOption "greetd";
    session = lib.mkOption {
      default = "${pkgs.hyprland}/bin/Hyprland";
    };
  };
  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${cfg.session}";
          user = "${username}";
        };
        default_session = {
          command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
          user = "greeter";
        };
      };
    };
  };
}
