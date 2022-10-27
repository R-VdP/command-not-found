{ pkgs ? import <nixpkgs> { } }:

{
  programs-sqlite = pkgs.runCommand "programs-sqlite" { } ''
    mkdir $out
    cp ${../programs-sqlite} $out/programs.sqlite
  '';
}

