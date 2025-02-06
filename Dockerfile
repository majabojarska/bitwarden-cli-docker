FROM debian:sid-slim

ARG BW_CLI_VERSION
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y wget unzip && \
    wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-sha256-${BW_CLI_VERSION}.txt --no-verbose -O bw.zip.sha256 && \
    wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-${BW_CLI_VERSION}.zip --no-verbose -O bw.zip && \
    echo "$(cat bw.zip.sha256) bw.zip" | sha256sum --check - && \
    unzip bw.zip && \
    chmod +x bw && \
    mv bw /usr/local/bin/bw && \
    apt remove -y wget unzip && \
    apt autoremove -y

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
