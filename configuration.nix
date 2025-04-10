{ config, pkgs, ... }:

{
  # -- System Boot Loader (GRUB for Dual-Booting) --
  boot.loader = {
    # Use GRUB as the boot loader.
    grub = {
      enable = true;
      device = "nodev"; # IMPORTANT: Verify this is correct for your system if issues arise.
      # Install GRUB to the EFI System Partition (ESP).
      efiSupport = true;
      # Enable os-prober to detect other operating systems (like Windows).
      # Requires `os-prober` package, which is added automatically when true.
      useOSProber = true;
    };
    # Allow NixOS to manage EFI boot variables.
    efi.canTouchEfiVariables = true;
    # Disable systemd-boot since we are using GRUB.
    systemd-boot.enable = false;
  };

  # -- Networking (WiFi via NetworkManager) --
  # Enable NetworkManager for managing network connections, including WiFi.
  networking.networkmanager.enable = true;

  # -- Hardware (Nvidia GPU) --
  hardware.nvidia = {
    # Use the proprietary Nvidia driver. Set to true for Nouveau (open-source).
    open = false;
    # Enable Nvidia modesetting. Recommended for Wayland/modern setups.
    modesetting.enable = true;
    # Power management can be tricky. Starting with it disabled is safer initially.
    # You might want to enable this later for better battery life on the laptop.
    # See: https://nixos.wiki/wiki/Nvidia#Power_Management
    powerManagement.enable = true;
    # Install the nvidia-settings utility.
    nvidiaSettings = true;
    # Use the 'stable' driver package. Other options include 'beta', 'latest', etc.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # Optional: If you encounter issues, explicitly adding modules might help,
  # but `hardware.nvidia` usually handles this.
  # boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];

  # -- Core System Settings --
  # Set the system timezone.
  time.timeZone = "America/Los_Angeles"; # Set to your timezone
  # Set the default locale.
  i18n.defaultLocale = "en_US.UTF-8";
  # Set the console keymap.
  console.keyMap = "us";

  # -- User Account --
  users.users.leyton = {
    isNormalUser = true;
    description = "Leyton Houck";
    home = "/home/leyton"; # Default home directory path
    # Add user to necessary groups:
    # 'wheel': Allows sudo access (configure sudo below)
    # 'networkmanager': Allows managing network connections via applets/cli
    # 'video': Often needed for hardware acceleration/graphics permissions
    # 'input': Sometimes needed for managing input devices
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    # Set Fish as the default shell for this user.
    shell = pkgs.fish;
    # !! SECURITY WARNING !!
    # Using initialPassword stores the password in the Nix store (/nix/store),
    # which is world-readable. This is ONLY acceptable for the very first setup.
    # CHANGE YOUR PASSWORD IMMEDIATELY after first login using `passwd`.
    # Consider generating a hash instead using `mkpasswd -m sha-512` and using:
    # initialHashedPassword = "your-generated-hash-here";
    initialPassword = "7574"; # CHANGE THIS IMMEDIATELY!
  };

  # Allow users in the 'wheel' group to use sudo.
  security.sudo.wheelNeedsPassword = true; # Set to false if you don't want to type sudo password

  # -- Nix Settings --
  # Enable experimental features needed for Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow installation of non-free packages (like Nvidia drivers).
  nixpkgs.config.allowUnfree = true;
  # Optional: Automatic garbage collection to clean up old Nix store paths.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # -- Essential Packages --
  # Install some essential system-wide packages.
  # More user-specific packages will be handled by Home Manager later via Flakes.
  environment.systemPackages = with pkgs; [
    git       # Needed for managing your Nix config and Flakes
    nano       # Or pkgs.nano - a basic text editor for emergency config changes
    wget      # Useful utility
    pciutils  # For `lspci` (useful for checking hardware like Nvidia card)
    usbutils  # For `lsusb`
    # Add fish here so it's available system-wide, even if not default for root
    fish
    neofetch
    # Add NetworkManager applet if you plan to use a minimal WM/DE without one built-in
    # networkmanagerapplet
  ];

  # -- Shell --
  # Make Fish available system-wide and configure it slightly.
  programs.fish.enable = true;


  system.stateVersion = "24.11";
}
