# ./configuration.nix

{ pkgs, ... }:

{
  imports = [
    # Using relative paths makes your configuration portable.
    ./modules/core.nix
    ./modules/shell/fish.nix
    ./modules/shell/kitty.nix
  ];

  # Set the flavor system-wide for other Catppuccin modules to use
  catppuccin.flavor = "macchiato";

  # bootloader configuration
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # Or "nodev" for EFI
  };

  # Set the system's state version
  system.stateVersion = "24.11";

  # test
}