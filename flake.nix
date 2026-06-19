{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    amd-ai = {
      url = "github:noamsto/nix-amd-ai";
      flake = true;
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, niri, amd-ai, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        {
          nixpkgs.overlays = [
            amd-ai.overlays.default
          ];
        }
        
        ./hosts/nixos/default.nix
        ./modules/core.nix
        ./modules/graphics.nix
        ./modules/desktop.nix
        ./modules/ai-stack.nix
        ./modules/noctalia.nix
        amd-ai.nixosModules.default
      ];
    };
  };
}