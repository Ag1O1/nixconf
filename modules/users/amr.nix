{
  flake.modules.nixos.user-amr = {pkgs, ...}: {
    users.users = {
      amr = {
        initialPassword = "password";
        shell = pkgs.fish;
        isNormalUser = true;
        extraGroups = [
          "ydotool"
          "networkmanager"
          "wheel"
          "libvirtd"
          "scanner" # printer scanner
          "lp"
          "video"
          "kvm"
          "libvirt" # some virtualization thing
          "docker"
          "wireshark" # for wireshark to work
          "dialout" # for arduino to work
        ];
      };
    };
    environment.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "foot";
    };
  };
}
