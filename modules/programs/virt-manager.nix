{
  tags = ["virt"];

  module = {
    pkgs,
    lib,
    ...
  }: let
    qemu = pkgs.qemu_kvm;
    libvirt = pkgs.libvirt;

    libvirtdConfig = pkgs.writeText "libvirtd.conf" ''
      auth_unix_ro = "polkit"
      auth_unix_rw = "polkit"
    '';

    qemuConfig = pkgs.writeText "qemu.conf" ''
      stdio_handler = "file"
      namespaces = []
    '';

    networkConfig = pkgs.writeText "network.conf" ''
      firewall_backend = "nftables"
    '';

    qemuOvmfMetadata = pkgs.stdenv.mkDerivation {
      name = "qemu-ovmf-metadata";
      version = qemu.version;

      nativeBuildInputs = [qemu];
      dontBuild = true;
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out

        cp ${qemu}/share/qemu/firmware/*.json $out/

        substituteInPlace $out/*.json \
          --replace-fail \
            "${qemu}/share/qemu/" \
            "/run/libvirt/nix-ovmf/"
      '';
    };

    setupLibvirt = pkgs.writeShellScript "libvirt-setup" ''
      mkdir -p /run/libvirt/nix-ovmf
      mkdir -p /var/lib/qemu/firmware

      # NixOS-compatible libvirt configuration locations.
      cp -f ${libvirtdConfig} /var/lib/libvirt/libvirtd.conf
      cp -f ${qemuConfig} /var/lib/libvirt/qemu.conf
      cp -f ${networkConfig} /var/lib/libvirt/network.conf

      readarray -t firmware_files < <(
        ${pkgs.jq}/bin/jq -rs '
          [
            .[] |
            .mapping.executable.filename,
            .mapping."nvram-template".filename
          ] |
          unique |
          .[]
        ' ${qemu}/share/qemu/firmware/*
      )

      cp -sfv "''${firmware_files[@]}" /run/libvirt/nix-ovmf/

      rm -f /var/lib/qemu/firmware/*.json
      cp ${qemuOvmfMetadata}/*.json /var/lib/qemu/firmware/
    '';
  in {
    environment.systemPackages = with pkgs; [
      virt-manager
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      virglrenderer
      qemu
      quickemu
      guestfs-tools
      libvirt
      libvirt-glib
      virtiofsd
    ];

    environment.etc."libvirt/qemu.conf".text = ''
      stdio_handler = "file"
      namespaces = []
    '';

    boot.kernelModules = [
      "kvm"
      "kvm_amd"
      "tun"
    ];

    finit.services.libvirtd = {
      description = "libvirtd";

      command = "${pkgs.writeShellScript "libvirtd-run" ''
        ${setupLibvirt}

        export PATH=${lib.makeBinPath [
          pkgs.qemu_kvm
          pkgs.dnsmasq
          pkgs.iproute2
          pkgs.iptables
          pkgs.dmidecode
          pkgs.netcat
        ]}:$PATH

        exec ${lib.getExe' pkgs.libvirt "libvirtd"}
      ''}";
    };

    finit.services.virtlogd = {
      description = "virtlogd";
      command = "${lib.getExe' pkgs.libvirt "virtlogd"}";
    };

    providers.firewall = {
      allowedUDPPorts = [53 67];
      allowedTCPPorts = [53];
    };

    custom.persist.directories = [
      "/var/lib/libvirt"
      "/etc/libvirt/qemu"
    ];
  };
}
