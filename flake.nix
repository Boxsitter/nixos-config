{
  description = "A NixOS configuration for Hyprland";

  # --- Flake Inputs ---
  #
  # This section defines the external dependencies of your configuration.
  # Here, we're using the 'nixos-unstable' channel of Nixpkgs.
  # The 'nixpkgs.url' specifies the exact version, making your system reproducible.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # --- Flake Outputs ---
  #
  # This section defines what your flake provides to other flakes or to the Nix commands.
  # We define a 'nixosConfigurations' output, which contains the configuration for your machine.
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        # specialArgs allows you to pass custom arguments down to all your modules.
        # This is useful for things like user settings, hostnames, etc.
        # We can expand this later if needed.
      };
      modules = [
        # This is the main entry point to your system configuration.
        ./configuration.nix
      ];
    };
  };
}