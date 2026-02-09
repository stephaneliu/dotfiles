  {
    description = "sliu's nix-darwin configuration";

    inputs = {
      # Package repository - using unstable for latest packages
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      # nix-darwin for macOS system management
      nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";  # Use same nixpkgs version
      };
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs }: {
      darwinConfigurations."sliu-work-macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";  # Apple Silicon; use "x86_64-darwin" for Intel
        modules = [
          ./darwin.nix
        ];
      };
    };
  }
