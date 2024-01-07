#! /usr/bin/env bash
set -e

BASE_URL="https://maven.neoforged.net/releases/net/neoforged"
JAR_NAME="neoforge-${NEO_VERSION}-installer.jar"

if [ "$MINECRAFT_VERSION" = "1.20.1" ]; then
    BASE_URL="$BASE_URL/forge/1.20.1-${NEO_VERSION}"
    JAR_NAME="forge-1.20.1-${NEO_VERSION}-installer.jar"
else
    BASE_URL="$BASE_URL/neoforge/${NEO_VERSION}"
fi

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USER=${USER:-"minecraft"}

set-up-user.sh "$USER" "$PUID" "$PGID"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading NeoForge";

    server_url="${BASE_URL}/${JAR_NAME}"

    curl -Lo "$JAR_NAME" -J "$server_url"

    java -jar "$JAR_NAME" --installServer

    echo "" >> user_jvm_args.txt
    echo "$JAVA_OPTS" >> user_jvm_args.txt
fi

echo "Accepting EULA"
echo "eula=true" > eula.txt

configure-server-properties.sh

chown -R "${USER}":"${USER}" /minecraft

COMMAND="${*:-"cd /minecraft; PATH=$(which java):$PATH ./run.sh nogui"}"

su -l "${USER}" -c "$COMMAND"
