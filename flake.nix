{
  description = "A NixOS configuration for Hyprland";

  # --- Flake Inputs ---
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Add other inputs here, e.g., home-manager
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
        # Main entry point to your system configuration
        ./configuration.nix
      ];
    };
  };
}