FROM debian:trixie-slim AS download

ARG BW_VERSION=2025.9.0

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq curl jq unzip \
    && curl --silent --location --output bw.zip "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-oss-linux-${BW_VERSION}.zip" \
    # Validate SHA256 before unzipping
    && echo $(curl --silent --location "https://api.github.com/repos/bitwarden/clients/releases/tags/cli-v${BW_VERSION}" | jq --raw-output ".assets[] | select(.name == \"bw-oss-linux-${BW_VERSION}.zip\") .digest" | cut -f2 -d:) bw.zip > sum.txt \
    && sha256sum --check sum.txt \
    && unzip bw.zip

FROM debian:trixie-slim

COPY --from=download bw /usr/local/bin/

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq curl

RUN useradd bitwarden --create-home --shell /bin/bash

USER bitwarden

WORKDIR /home/bitwarden

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

