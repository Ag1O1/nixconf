{
  tags = ["graphical"];
  module = {pkgs, ...}: {
    hj = {
      packages = [pkgs.calcurse];
      xdg.config.files."calcurse/hooks/post-save".text = ''
        #!/bin/sh
        calcurse-vdir export -f "$HOME/.local/share/calendars/personal"
      '';
    };
  };
}
