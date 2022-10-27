{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: {
        packages = import ./pkgs {
          pkgs = import nixpkgs { inherit system; };
        };
        defaultPackage = self.packages.${system}.programs-sqlite;
      })
    //
    {
      nixosModules.command-not-found = import ./modules/command-not-found;
      nixosModule = self.nixosModules.command-not-found;
    };
}

