{inputs, ...}: {
  flake.modules.nixos.user-amr = {
    pkgs,
    lib,
    config,
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
        hashedPasswordFile = config.sops.secrets.user_pass.path;
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
