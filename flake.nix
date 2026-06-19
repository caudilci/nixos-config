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
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, amd-ai, home-manager, ... }: {
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

        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.cc = import ./modules/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
      ];
    };
  };
}