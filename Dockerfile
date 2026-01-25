FROM debian:trixie-slim AS download

ARG BW_CLI_VERSION=2025.12.1

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq curl jq unzip \
    && curl --silent --location --output bw.zip "https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-${BW_CLI_VERSION}.zip" \
    # Validate SHA256 before unzipping
    && echo $(curl --silent --location "https://api.github.com/repos/bitwarden/clients/releases/tags/cli-v${BW_CLI_VERSION}" | jq --raw-output ".assets[] | select(.name == \"bw-oss-linux-${BW_CLI_VERSION}.zip\") .digest" | cut -f2 -d:) bw.zip > sum.txt \
    && sha256sum --check sum.txt \
    && unzip bw.zip

FROM debian:trixie-slim AS runtime

ARG BW_PORT=8087 # Port number for exposing the REST API

ENV BW_PORT=$BW_PORT

COPY --from=download bw /usr/local/bin/

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq curl

RUN useradd bitwarden --create-home --shell /bin/bash

USER bitwarden

WORKDIR /home/bitwarden

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
