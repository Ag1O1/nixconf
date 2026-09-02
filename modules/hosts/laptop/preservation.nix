{inputs, ...}: {
  flake.nixos.laptopPreservation = {
    imports = [inputs.preservation.nixosModules.default];
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
            how = "symlink";
          }
          {file = "/etc/supergfxd.conf";}
          {file = "/etc/ly/save.txt";}
        ];
        directories = [
          "/var/lib/nixos"
          "/var/lib/systemd/timers"
          "/var/lib/NetworkManager"
          "/var/lib/bluetooth"
          "/var/lib/libvirt"
          "/var/lib/waydroid"
          "/var/lib/flatpak"
          "/var/lib/cups"
          "/var/lib/private/ollama"
          "/var/lib/private/open-webui"
          "/var/log"
          "/etc/ssh"
          "/etc/NetworkManager/system-connections"
          "/etc/asusd"
        ];
      };
    };
  };
}
