# bitwarden-cli-docker

An opinionated [Bitwarden CLI](https://bitwarden.com/help/cli/) Docker image.

- API token authentication.
- Implements a session management lifecycle. Sessions are persisted and reused across container startups.

## To-do

- [ ] Make port number configurable
- [ ] Impl. PR check, just build the image for now.
- [ ] Document versioning format.
- [ ] Automate CLI version updates.
  - Run workflow on a daily schedule.
  - Generates diff version update and opens a PR to review and merge.
- [ ] Impl. release drafter.
- [ ] Automated testing pipeline?

## License and credits

This is a spin-off of the MIT-licensed (charlesthomas/bitwarden-cli)[https://github.com/charlesthomas/bitwarden-cli] project.

See the [LICENSE](./LICENSE) for more details.
