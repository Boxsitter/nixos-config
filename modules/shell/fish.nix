# ./modules/shell/fish.nix
{ pkgs, ... }:

{
  # Enable the fish shell program.
  programs.fish.enable = true;

  # This is the key part: it reads your shell script from the file at build time.
  # The path is relative to this .nix file.
  programs.fish.shellInit = builtins.readFile /etc/nixos/config.fish;
}