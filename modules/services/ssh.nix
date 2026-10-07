{
  tags = ["core"];
  module = {fm, ...}: {
    imports = [fm.openssh];
    services.openssh.enable = true;
    custom.persist.directories = [
      "/etc/ssh"
    ];
  };
}
