{
  tags = ["graphical"];
  module = {
    fm,
    cm,
    ...
  }: {
    imports = [cm.pipewire fm.rtkit];
    services.rtkit.enable = true;
    programs = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        extraConfig.pipewire = {
          "10-defaults" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.allowed-rates" = [44100 48000];
              "default.clock.quantum" = 1024;
              "default.clock.min-quantum" = 32;
              "default.clock.max-quantum" = 8192;
            };
          };
        };

        wireplumber = {
          enable = true;

          extraConfig = {
            "10-disable-libcamera" = {
              "wireplumber.profiles" = {
                main."monitor.libcamera" = "disabled";
              };
            };
          };
        };
      };
    };
  };
}
