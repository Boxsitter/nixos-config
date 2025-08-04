{
  description = "A NixOS configuration for Hyprland";

  # --- Flake Inputs ---
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # --- ADD THIS INPUT ---
    catppuccin.url = "github:catppuccin/nix";
  };

  # --- Flake Outputs ---
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        # Pass flake inputs to all modules
        inherit inputs;
      };
      modules = [
        # --- ADD THIS LINE TO APPLY THE THEME ---
        inputs.catppuccin.nixosModules.catppuccin
        # Main entry point to your system configuration
        /etc/nixos/configuration.nix
      ];
    };
  };
}