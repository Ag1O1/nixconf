{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.polkit;
in {
  options.modules.services.polkit = {
    enable = lib.mkEnableOption "polkit";
  };
  config = mkIf cfg.enable {
    security.polkit.enable = true;
    programs.seahorse.enable = true;
    systemd.user.services.polkit-pantheon-authentication-agent-1 = {
      description = "Pantheon PolicyKit agent";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
    };
  };
}
