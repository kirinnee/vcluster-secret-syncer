{ pkgs, atomi, atomi_classic, pkgs-sep-24-23 }:
let

  all = {
    atomipkgs = (
      with atomi;
      {
        inherit
          infisical
          pls;
      }
    );
    atomipkgs_classic = (
      with atomi_classic;
      {
        inherit
          sg;
      }
    );
    sep-24-23 = (
      with pkgs-sep-24-23;
      {
        inherit
          coreutils
          sd
          bash
          git
          jq
          yq-go
          go

          nodejs_20
          docker
          golangci-lint

          # lint
          treefmt

          # infra
          gitlint
          shellcheck
          ;

      }
    );
  };
in
with all;
atomipkgs //
atomipkgs_classic //
sep-24-23
