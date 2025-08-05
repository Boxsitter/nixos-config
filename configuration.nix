{ pkgs, ... }:

{
  imports = [
    # Using relative paths makes your configuration portable.
    ./modules/core.nix
    ./modules/shell/fish.nix
    ./modules/gui/kitty.nix # Corrected path to be in modules/gui
  ];

  # Set the flavor system-wide for other Catppuccin modules to use
  catppuccin.flavor = "macchiato";

  # Enable Catppuccin theming for the TTY console
  catppuccin.console = true;

  # Bootloader configuration
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # Or "nodev" for EFI
  };

  # Set the system's state version
  system.stateVersion = "24.11";
}