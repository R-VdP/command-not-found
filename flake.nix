{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    programs-sqlite = {
      url = "path:programs.sqlite";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, programs-sqlite }:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      packages = forAllSystems
        (system:
          {
            programs-sqlite =
              let
                pkgs = import nixpkgs { inherit system; };
              in
              pkgs.runCommand "programs-sqlite" { } ''
                mkdir $out
                cp ${programs-sqlite} $out/programs.sqlite
              '';
          }
        );
      defaultPackage =
        forAllSystems (system: self.packages.${system}.programs-sqlite);
    };
}

