{ pkgs, packages }:
with packages;
{
  system = [
    coreutils
    sd
    bash
    jq
    yq-go
  ];

  dev = [
    pls
    git
  ];

  infra = [
  ];

  main = [
    docker
    go
  ];

  lint = [
    # core
    treefmt

    gitlint
    shellcheck
    golangci-lint
  ];

  releaser = [
    nodejs_20
    sg
  ];
}
