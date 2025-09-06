# ./modules/core.nix

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # GRUB bootloader configuration for dual-boot
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;  # This detects Windows
      default = "saved";   # Remember last choice, or set to 1 for Windows default
      timeout = 10;        # 10 seconds to choose
    };
    efi.canTouchEfiVariables = true;
  };

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

  # Set hostname - change this to your preferred hostname
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Intel WiFi driver support
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = with pkgs; [
    linux-firmware
  ];
  
  # Enable Intel WiFi drivers
  boot.kernelModules = [ "iwlwifi" ];
  
  # Intel WiFi firmware and drivers
  hardware.enableAllFirmware = true;

  # Graphics drivers configuration
  services.xserver.videoDrivers = [ "nvidia" ]; # Change to "amdgpu" for AMD or remove for Intel integrated
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For 32-bit applications
  };

  # NVIDIA configuration (comment out if not using NVIDIA)
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
  };

  # Security configuration
  security.sudo.wheelNeedsPassword = true;
  security.polkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  environment.systemPackages = with pkgs; [
    # Core system tools
    git nano wget curl pciutils usbutils lshw htop tree
    
    # Shell and terminal
    fish neofetch eza starship
    
    # Development tools
    gcc mono jdk python3 racket bc
    
    # System utilities
    os-prober   # For detecting other operating systems in dual-boot
    ntfs3g      # For NTFS support (Windows partitions)
    unzip zip   # Archive utilities
    
    # Network tools
    networkmanagerapplet
  ];
}