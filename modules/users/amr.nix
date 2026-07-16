{inputs, ...}: {
  flake.modules.nixos.user-amr = {
    pkgs,
    lib,
    ...
  }: let
    user = "amr";
  in {
    imports = [
      inputs.hjem.nixosModules.default

      (
        lib.mkAliasOptionModule
        ["hj"]
        [
          "hjem"
          "users"
          "${user}"
        ]
      )
    ];
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
      TERMINAL = "ghostty";
    };
  };
}
