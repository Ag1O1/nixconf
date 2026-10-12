{
  # Misc development packages
  tags = ["rigel"];
  module = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.clang
      pkgs.clang-tools
      pkgs.gcc

      pkgs.python3

      pkgs.dotnet-sdk_10
      pkgs.netcoredbg
    ];
  };
}
