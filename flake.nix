# ./flake.nix
{
  description = "A NixOS configuration for KDE Plasma";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Replace "nixos" with your actual hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        inputs.catppuccin.nixosModules.catppuccin
        # --- CHANGE THIS LINE ---
        ./configuration.nix # Use the relative path to the file
      ];
    };
  };
}