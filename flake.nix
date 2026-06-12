{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri.url = "github:niri-wm/niri";
    noctalia.url = "github:noctalia-dev/noctalia";
    amd-ai = {
      url = "github:noamsto/nix-amd-ai";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, niri, noctalia, amd-ai, ... }: {
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
        noctalia.nixosModules.noctalia
      ];
    };
  };
}
