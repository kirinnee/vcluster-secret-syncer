{ pkgs, atomi, pkgs-feb-23-24 }:
let

  all = {
    atomipkgs = (
      with atomi;
      {
        inherit
          infisical
          pls
          sg;
      }
    );
    feb-23-24 = (
      with pkgs-feb-23-24;
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
feb-23-24
