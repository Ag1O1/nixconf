{
  tags = ["graphical"];
  module = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libmtp
    ];
    hj.packages = [
      (pkgs.nemo-with-extensions.override {
        extensions = with pkgs; [nemo-fileroller];
      })
    ];
  };
}
