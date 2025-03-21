{ pkgs, ... }:

{
  # System-wide packages
  environment.systemPackages = with pkgs; [
    vscode                       # Visual Studio Code
    git                          # Git version control system
    neofetch                     # Neofetch system information tool
    fish                         # The Fish shell (installed system-wide)
  ];
}