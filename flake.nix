{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      packages = forAllSystems
        (system:
          import ./pkgs {
            pkgs = import nixpkgs { inherit system; };
          }
        );
      defaultPackage =
        forAllSystems (system: self.packages.${system}.programs-sqlite);

      nixosModules.command-not-found = import ./modules/command-not-found;
      nixosModule = self.nixosModules.command-not-found;
    };
}

