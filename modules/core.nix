# ./modules/core.nix

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Configure console with a modern font and Catppuccin theme
  console = {
    # Use Terminus font which is a standard, reliable console font
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v20n.psf.gz";  # Larger size (20) for better readability
    packages = with pkgs; [ terminus_font ];
    
    # Enable Catppuccin theme for console
    catppuccin = {
      enable = true;
      # The flavor is already set in configuration.nix
    };
  };

  # Keep kernel parameters clean
  boot.kernelParams = [
    # Other kernel parameters can stay here
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

  environment.systemPackages = with pkgs; [
    git nano wget pciutils usbutils fish neofetch eza starship gcc mono jdk python3 racket bc
  ];
}