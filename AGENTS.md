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
