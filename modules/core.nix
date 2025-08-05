# ./modules/core.nix

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Set a modern font for the TTY console
  console.font = "ter-u16n";

  # Set the 16 TTY colors to the Catppuccin Macchiato palette
  # This is done via kernel parameters
  boot.kernelParams = [
    "vt.default_red=0x24,0xf3,0xa6,0xf9,0x89,0xf5,0x94,0xcb,0x93,0xf3,0xa6,0xf9,0x89,0xf5,0x94,0xca"
    "vt.default_grn=0x27,0x8b,0xe3,0xe2,0xdc,0xc2,0xe2,0xa6,0x98,0x8b,0xe3,0xe2,0xdc,0xc2,0xe2,0xd3"
    "vt.default_blu=0x3a,0xa8,0xa1,0xaf,0xeb,0xe7,0xd5,0xf7,0x93,0xa8,0xa1,0xaf,0xeb,0xe7,0xd5,0xf5"
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