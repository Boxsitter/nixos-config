# ./modules/shell/kitty.nix
{ pkgs, ... }:

{
  # Install JetBrains Mono Nerd Font using the new attribute set
  fonts.packages = [
    pkgs.nerd-fonts.JetBrainsMono
  ];

  # Just install Kitty system-wide
  environment.systemPackages = with pkgs; [
    kitty
  ];

  # Create a default config for all users
  environment.etc."xdg/kitty/kitty.conf".text = ''
    font_family JetBrainsMono Nerd Font
    font_size 14
    background_opacity 0.9
    
    # Catppuccin Macchiato theme
    include ${pkgs.kitty-themes}/share/kitty-themes/themes/Catppuccin-Macchiato.conf
  '';
}