{
  tags = ["graphical"];
  module = {pkgs, ...}: {
    programs.plymouth = {
      enable = true;
      theme = pkgs.adi1090x-plymouth-themes.override {
        selected_themes = ["blockchain"];
      };
      settings.Daemon.Theme = "blockchain";
    };
  };
}
