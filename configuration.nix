{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/system.nix
      ./modules/drivers.nix
      ./modules/services.nix
      ./modules/security.nix
      ./modules/networking.nix
      ./modules/users.nix
      ./modules/nix.nix
      ./modules/shell.nix
      ./modules/packages.nix
      ./modules/home.nix

      # Hyprland & GUI setup from Hydenix
      ./modules/gui/hyprland.nix
      ./modules/gui/theming.nix
      ./modules/gui/xdg-portal.nix
      ./modules/gui/programs.nix
      ./modules/gui/audio.nix
      ./modules/gui/hyde.nix

      ./modules/home-activation.nix
    ];

  system.stateVersion = "24.11";
}
