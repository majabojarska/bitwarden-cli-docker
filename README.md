# bitwarden-cli-docker

An opinionated [Bitwarden CLI](https://bitwarden.com/help/cli/) Docker image.

- API token authentication.
- Implements a session management lifecycle. Sessions are persisted and reused across container startups.

## To-do

1. [ ] Add pre-commit
1. [ ] Add shellcheck to status checks
1. [ ] Make port number configurable
1. [x] Impl. PR check, just build the image for now.
1. [ ] Document versioning format.
1. [ ] Automate CLI version updates.
   - Run workflow on a daily schedule.
   - Generates diff version update and opens a PR to review and merge.

1. [ ] Impl. release drafter.
1. [ ] Automated testing pipeline?

## License and credits

This is a spin-off of the MIT-licensed [charlesthomas/bitwarden-cli](https://github.com/charlesthomas/bitwarden-cli) project.

See the [LICENSE](./LICENSE) for more details.
