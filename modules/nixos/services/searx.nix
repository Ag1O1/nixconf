{
  flake.modules.nixos.searx = {
    services.searx = {
      enable = true;
      openFirewall = true;
      settings = {
        server.port = 8081;
        server.bind_address = "127.0.0.1";
        server.secret_key = "62a09dc1c46b8c078a43a94f270d931007c8546826bf63906f569ae53968697c"; # DO NOT COMMIT
        engines = [
          {
            name = "google";
            engine = "google";
            shortcut = "go";
            disabled = false;
          }
          {
            name = "duckduckgo";
            engine = "duckduckgo";
            shortcut = "ddg";
            disabled = false;
          }
          {
            name = "brave";
            engine = "brave";
            shortcut = "br";
            disabled = false;
          }
        ];
        search = {
          formats = ["html" "json"];
        };
      };
    };
  };
}
