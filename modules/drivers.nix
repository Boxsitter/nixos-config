{ config, pkgs, ... }:

{
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ config.boot.kernelPackages.nvidiaPackages.stable ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}