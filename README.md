# bitwarden-cli-docker

[![Publish Docker image](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/release.yaml/badge.svg)](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/release.yaml)
[![Build](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/status.yaml/badge.svg)](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/status.yaml)
[![Scheduled update](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/update_cli.yaml/badge.svg)](https://github.com/majabojarska/bitwarden-cli-docker/actions/workflows/update_cli.yaml)

[![Docker Image Version](https://img.shields.io/docker/v/majabojarska/bitwarden-cli)](https://hub.docker.com/r/majabojarska/bitwarden-cli/tags)
[![Docker Image Size](https://img.shields.io/docker/image-size/majabojarska/bitwarden-cli)](https://hub.docker.com/r/majabojarska/bitwarden-cli/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/majabojarska/bitwarden-cli)](https://hub.docker.com/r/majabojarska/bitwarden-cli/tags)

An opinionated [Bitwarden CLI](https://bitwarden.com/help/cli/) Docker image.

- API token authentication.
- Features a session management lifecycle, facilitating session reuse across container startups.

## Getting started

### Image

The image is available both via
[Docker Hub](https://hub.docker.com/r/majabojarska/bitwarden-cli/tags)
and
[GHCR](https://github.com/majabojarska/bitwarden-cli-docker/pkgs/container/bitwarden-cli):

```sh
docker.io/majabojarska/bitwarden-cli
```

```sh
ghcr.io/majabojarska/bitwarden-cli
```

### Configuration

Configuration is provided via environment variables. We can identify two variable classes:

- So-called upstream variables. These are defined and owned by the Bitwarden CLI ([1](https://bitwarden.com/help/cli/), [2](https://bitwarden.com/help/data-storage/#CLI)):
  - `BITWARDENCLI_APPDATA_DIR` - storage location for the session file.
    This facilitates session reuse across container restarts.
    Essentially, this helps the CLI behave as it would normally in a non-containerized shell.
  - `BITWARDENCLI_DEBUG` - set to `"true"` in order to ramp up log verbosity. Useful for troubleshooting.
- Image-specific variables. These are defined by this project, for the purpose of operating the CLI
  in a containerized environment.
  - `BW_HOST` - either `vault.bitwarden.eu` or `vault.bitwarden.com`. Choose the one appropriate for your account.
  - `BW_CLIENTID` - generated with your API key, [see Bitwarden docs](https://bitwarden.com/help/personal-api-key/).
  - `BW_CLIENTSECRET` - same as above.

### Docker compose

Putting it all together, here's a minimal docker compose file:

```docker-compose
services:
  backend:
    image: majabojarska/bitwarden-cli
    environment:
      # Upstream envs: https://bitwarden.com/help/cli/
      BITWARDENCLI_APPDATA_DIR: /home/bitwaden/appdata
      BITWARDENCLI_DEBUG: "false"

      # Image-specific envs
      BW_HOST: "vault.bitwarden.eu" # or *.com
      BW_CLIENTID: "your_clientid"
      BW_CLIENTSECRET: "supersecret"
    volumes:
      - appdata:/home/bitwarden/appdata # Stores the session file across restarts

volumes:
  appdata:
```

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
1. [x] Cool badges 😎.
1. [x] Getting started docs.
1. [ ] Automated testing pipeline?
1. [ ] Example docker-compose file.
1. [ ] Link to helm chart repo once that's ready.

## License and credits

This is a spin-off of the MIT-licensed
[charlesthomas/bitwarden-cli](https://github.com/charlesthomas/bitwarden-cli) project.

See the [LICENSE](./LICENSE) for more details.
