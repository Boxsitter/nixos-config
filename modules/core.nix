# modules/core.nix
{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix # This path is relative to configuration.nix
  ];

  # --- System Boot Loader (GRUB) ---
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true; #
    };
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false; #
  };

  # --- Networking ---
  networking.networkmanager.enable = true; #

  # --- Hardware (Nvidia GPU) ---
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true; #
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable; #
  };

  # --- Core System Settings ---
  time.timeZone = "America/Los_Angeles"; #
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us"; #

  # --- User Account ---
  users.users.leyton = {
    isNormalUser = true;
    description = "Leyton Houck"; #
    home = "/home/leyton";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish; #
    initialPassword = "7574"; #
  };

  security.sudo.wheelNeedsPassword = true; #

  # --- Nix Settings ---
  nix.settings.experimental-features = [ "nix-command" ]; #
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true; #
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- Essential System-Wide Packages ---
  environment.systemPackages = with pkgs; [
    git
    nano
    wget
    pciutils
    usbutils
    fish
    neofetch
    eza
    starship
  ];

  system.stateVersion = "24.11";
}