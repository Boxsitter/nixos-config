{ pkgs, ... }:

let
  cfgDir = ./hyprland-config;
in {
  environment.systemPackages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    kitty
    rofi
    waybar
    mako
    swaylock
    swww
    brightnessctl
    libnotify
    wl-clipboard
    playerctl
    polkit-kde-agent
  ];

  programs.hyprland.enable = true;

  # Provide all configuration files
  environment.etc = {
    "xdg/hypr/hyprland.conf".source = "${cfgDir}/hyprland.conf";
    "xdg/hypr/keybindings.conf".source = "${cfgDir}/keybindings.conf";
    "xdg/hypr/nvidia.conf".source = "${cfgDir}/nvidia.conf";

    # Optional (add if/when you include these)
    "xdg/hypr/monitors.conf".source = "${cfgDir}/monitors.conf";
    "xdg/hypr/windowrules.conf".source = "${cfgDir}/windowrules.conf";
  };

  # Required services
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}
