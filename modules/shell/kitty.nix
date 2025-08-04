# ./modules/gui/kitty.nix
{ pkgs, ... }:

{
  # 1. Install a nice font. JetBrains Mono is a great choice.
  # We use NerdFonts to get extra icons and glyphs.
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # 2. Enable and configure the Kitty terminal.
  programs.kitty = {
    enable = true;
    # 3. Use the catppuccin-nix module to apply the theme.
    theme = "Macchiato"; # Can be "Latte", "Frappe", "Macchiato", or "Mocha"
    # 4. Set the font and other custom settings.
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 14;
      # Macchiato-specific background opacity
      background_opacity = "0.9";
      # You can add any other kitty setting here, e.g.:
      # scrollback_lines = 10000;
      # enable_audio_bell = false;
    };
  };
}