# modules/core.nix
{ config, pkgs, ... }:

{
  # This import remains an absolute path, which is correct.
  # hardware-configuration.nix is machine-specific and not part of your portable config.
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  networking.networkmanager.enable = true;

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  users.users.leyton = {
    isNormalUser = true;
    description = "Leyton Houck";
    home = "/home/leyton";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
    initialPassword = "7574";
  };

  security.sudo.wheelNeedsPassword = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Essential packages are kept here. fish-related packages were moved.
  environment.systemPackages = with pkgs; [
    git nano wget pciutils usbutils fish neofetch eza starship gcc mono jdk python3 racket bc
  ];
}