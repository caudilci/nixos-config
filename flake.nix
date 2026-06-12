{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri.url = "github:niri-wm/niri";
    amd-ai.url = "github:noamsto/nix-amd-ai";
  };

  outputs = { self, nixpkgs, niri, amd-ai, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        {
          nixpkgs.overlays = [
            amd-ai.overlays.default
            niri.overlays.default
          ];
        }

        ./hosts/nixos/default.nix
        ./modules/core.nix
        ./modules/graphics.nix
        ./modules/desktop.nix
        ./modules/ai-stack.nix
        amd-ai.nixosModules.default
        niri.nixosModules.niri
      ];
    };
  };
}