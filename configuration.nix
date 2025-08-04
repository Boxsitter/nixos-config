{ pkgs, ... }:

{
  imports = [
    # Import the core system configuration
    /etc/nixos/modules/core.nix

    # Import shell-specific configurations
    /etc/nixos/modules/shell/fish.nix

    # Import the GUI configuration (Hyprland)
    # You can comment out this line to build a headless system
#    /etc/nixos/modules/gui/hyprland.nix
  ];

  # Bootloader configuration remains here as it's fundamental
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # Or "nodev" for EFI
  };

  # Set the system's state version
  system.stateVersion = "24.11";
}