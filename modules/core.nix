# modules/core.nix
{ config, pkgs, ... }:

{
  imports = [
    # This file is machine-specific and should be generated on the target system
    /etc/nixos/hardware-configuration.nix
  ];

  # --- Networking ---
  networking.networkmanager.enable = true;

  # --- Hardware (Nvidia GPU) ---
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- Core System Settings ---
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # --- User Account ---
  users.users.leyton = {
    isNormalUser = true;
    description = "Leyton Houck";
    home = "/home/leyton";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish; # This sets fish as the default shell for the user
    initialPassword = "7574"; # CHANGE THIS IMMEDIATELY!
  };

  security.sudo.wheelNeedsPassword = true;

  # --- Nix Settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- Essential System-Wide Packages ---
  environment.systemPackages = with pkgs; [
    git nano wget pciutils usbutils fish neofetch eza starship gcc mono jdk python3 racket bc
  ];
}