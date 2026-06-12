{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri.url = "github:niri-wm/niri";
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    amd-ai = {
      url = "github:noamsto/nix-amd-ai";
      flake = true;
    };
  };

  outputs = inputs@{ self, nixpkgs, niri, noctalia, amd-ai, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        {
          nixpkgs.overlays = [
            amd-ai.overlays.default
            niri.overlays.default
          ];
        }
        ./noctalia.nix

        ./hosts/nixos/default.nix
        ./modules/core.nix
        ./modules/graphics.nix
        ./modules/desktop.nix
        ./modules/ai-stack.nix
        amd-ai.nixosModules.default
        noctalia.nixosModules.noctalia
      ];
    };
  };
}
