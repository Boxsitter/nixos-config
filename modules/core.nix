# ./modules/core.nix

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Install and set the Terminus font for console
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u16n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    
    # Set the console colors directly through the NixOS console module
    # instead of kernel parameters
    colors = [
      "24273a" "f38ba8" "a6e3a1" "f9e2af" 
      "89dceb" "f5c2e7" "94e2d5" "cba6f7"
      "9398b3" "f38ba8" "a6e3a1" "f9e2af" 
      "89dceb" "f5c2e7" "94e2d5" "cad3f5"
    ];
  };

  # Remove the color-related kernel parameters
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