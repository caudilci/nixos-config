{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    niri.url = "github:niri-wm/niri";

    amd-ai = {
      url = "git+file:///home/cc/nix-amd-ai";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, niri, amd-ai, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      overlays = [
        amd-ai.overlays.default
        # The official flake provides an overlay for the niri package
        niri.overlays.default
      ];

      modules = [
        ./hosts/nixos/default.nix
        ./modules/core.nix
        ./modules/graphics.nix
        ./modules/desktop.nix
        ./modules/ai-stack.nix
        amd-ai.nixosModules.default
        # The official flake provides the NixOS module here
        niri.nixosModules.niri
      ];
    };
  };
}