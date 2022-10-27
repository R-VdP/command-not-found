{ pkgs, ... }:

{
  config.programs.command-not-found.dbPath =
    "${(pkgs.callPackage ../../pkgs {}).programs-sqlite}/programs.sqlite";
}

