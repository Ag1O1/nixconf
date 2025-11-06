{ lib, ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      NMI_WATCHDOG = 0; # Set to 1 if debugging
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_BAT = 0;
      PLATFORM_PROFILE_ON_BAT = "balanced";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      PLATFORM_PROFILE_ON_AC = "performance";
      USB_AUTOSUSPEND = 0;
      START_CHARGE_THRESH_BAT1= 75;
      STOP_CHARGE_THRESH_BAT1= 80;
    };
  };
  services.power-profiles-daemon.enable = lib.mkForce false;
  powerManagement.powertop.enable = true;
  services.supergfxd.enable = true;
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia = {
    open = true;
    powerManagement.finegrained = false;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:102:0:0";
    };
  };
}
