# bitwarden-cli-docker

[![Publish Docker image](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/release.yaml/badge.svg)](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/release.yaml)
[![Build](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/status.yaml/badge.svg)](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/status.yaml)
[![Scheduled update](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/update_cli.yaml/badge.svg)](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/update_cli.yaml)

An opinionated [Bitwarden CLI](https://bitwarden.com/help/cli/) Docker image.

- API token authentication.
- Implements a session management lifecycle. Sessions are persisted and reused
  across container startups.

## Releases

### Versioning

This project's versioning format is a derivative of Bitwarden CLI versioning.

An image tag consists of:

1. The currently used [Bitwarden CLI version tag](https://github.com/bitwarden/clients/releases?q=CLI&expanded=true), e.g. `2025.10.0`, which follows [CalVer](https://calver.org/).
1. The image's revision number, for the given upstream CLI version, starting at `0`. This resets for each CLI version.

The two segments are concatenated with a dot ('.') character, for example:

```plain
{BW_CLI_VERSION}.{IMG_REVISION}

# Third image revision for CLI 2025.10.0
2025.10.0.2
```

### Support lifecycle

- Only one CLI version is supported at any given time, which usually is the latest.
- As soon as the CLI version is upgraded in this project, support for the previous versions stops.
  - Any fixes or improvements are shipped with the latest supported CLI version.

## To-do

1. [x] Add pre-commit.
1. [x] Add shellcheck to status checks.
1. [x] Make port number configurable.
1. [x] Impl. PR check, just build the image for now.
1. [x] Document versioning format.
1. [x] Automate CLI version updates.
   - Run workflow on a daily schedule.
   - Generates diff version update and opens a PR to review and merge.
1. [x] Impl. release drafter.
1. [x] Impl. release pipeline.
1. [ ] Automated testing pipeline?
1. [ ] Example docker-compose file.
1. [ ] Link to helm chart repo once that's ready.

## License and credits

This is a spin-off of the MIT-licensed
[charlesthomas/bitwarden-cli](https://github.com/charlesthomas/bitwarden-cli) project.

See the [LICENSE](./LICENSE) for more details.
