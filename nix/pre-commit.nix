{ packages, formatter, pre-commit-lib }:
pre-commit-lib.run {
  src = ./.;

  # hooks
  hooks = {
    # formatter
    treefmt = {
      enable = true;
      excludes = [ "chart/.*(yaml|yml)" "chart/README.md" "Changelog.md" "docs/developer/CommitConventions.md" ];
    };

    # linters From https://github.com/cachix/pre-commit-hooks.nix
    shellcheck = {
      enable = false;
    };

    a-golangci-lint = {
      enable = true;
      name = "Golang CI Linter";
      description = "Run golangci-lint on all go files";
      entry = "${packages.golangci-lint}/bin/golangci-lint run";
      language = "system";
      files = ".*\\.go$";
      pass_filenames = false;
    };

    a-infisical = {
      enable = true;
      name = "Secrets Scanning (Past Commits)";
      description = "Scan for possible secrets in past commits";
      entry = "${packages.infisical}/bin/infisical scan . -v";
      language = "system";
      pass_filenames = false;
    };

    a-infisical-staged = {
      enable = true;
      name = "Secrets Scanning (Staged)";
      description = "Scan for possible secrets in staged files";
      entry = "${packages.infisical}/bin/infisical scan git-changes --staged -v";
      language = "system";
      pass_filenames = false;
    };

    a-enforce-gitlint = {
      enable = true;
      name = "Enforce gitlint";
      description = "Enforce atomi_releaser conforms to gitlint";
      entry = "${packages.sg}/bin/sg gitlint";
      files = "(atomi_release\\.yaml|\\.gitlint)";
      language = "system";
      pass_filenames = false;
    };

    a-shellcheck = {
      enable = true;
      name = "Shell Check";
      entry = "${packages.shellcheck}/bin/shellcheck";
      files = ".*sh$";
      language = "system";
      pass_filenames = true;
    };

    a-enforce-exec = {
      enable = true;
      name = "Enforce Shell Script executable";
      entry = "${packages.coreutils}/bin/chmod +x";
      files = ".*sh$";
      language = "system";
      pass_filenames = true;
    };
  };

  settings = {
    treefmt = {
      package = formatter;
    };
  };
}
