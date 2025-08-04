{ pkgs, ... }:

{
  imports = [
    # Import the core system configuration
    /etc/nixos/modules/core.nix

    # Import shell-specific configurations
    /etc/nixos/modules/shell/fish.nix

    # Import the Kitty terminal configuration
    /etc/nixos/modules/gui/kitty.nix
  ];

  # Set the flavor system-wide for other modules to use
  catppuccin.flavor = "macchiato";

  # --- ADD THIS LINE ---
  # This enables Catppuccin theming for the TTY console.
  catppuccin.console = true;

  # Bootloader configuration remains here as it's fundamental
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # Or "nodev" for EFI
  };

  # Set the system's state version
  system.stateVersion = "24.11";
}