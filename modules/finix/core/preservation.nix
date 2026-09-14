{
  cm,
  config,
  ...
}: let
  cfg = config.custom.persist;
in {
  imports = [cm.preservation];
  config = {
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        files =
          [
            {
              file = "/etc/machine-id";
              #inInitrd = true;
              how = "symlink";
            }
          ]
          ++ cfg.files;
        directories =
          [
            "/var/log"
          ]
          ++ cfg.directories;
      };
    };
  };
}
