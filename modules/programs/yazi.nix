{
  tags = ["graphical" "server"];
  module = {pkgs, ...}: {
    environment.systemPackages = [pkgs.yazi];
  };
}
