# Agent notes

`sendmyl` is a Python library and CLI for sending email.

- Preserve the public API and command behavior documented in `README.md`.
- Run the repository's Python lint workflow and add focused tests for behavior
  changes.
- Use a local SMTP sink or test account for integration checks; do not send
  real messages while validating changes.
- Before changing workflows, check for reusable workflows or actions in
  [ci-workflows](https://github.com/pschmitt/ci-workflows) and preserve
  existing triggers, parameters, and check coverage.

## Nix

- Export `packages.<system>.default` and the named `sendmyl` package; do not
  add legacy output aliases.
- The development shell inherits package dependencies through `inputsFrom` and
  imports Python modules from the checkout. Keep it usable without installing
  the project into a virtual environment.
- Run Nix evaluations and builds on a remote worker. Validate changes with
  `nix flake check --no-build --all-systems`, a default package build, and a
  checkout-module import inside `nix develop`. Use CLI `--help` for a smoke
  test without making network requests or sending mail.
