#! /usr/bin/env bash
set -e

JAR_NAME="server-${MINECRAFT_VERSION}.jar"

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USER=${USER:-"minecraft"}

if [ ! "$(id -u "${USER}")" -eq "$PUID" ]; then usermod -o -u "$PUID" "${USER}" ; fi
if [ ! "$(id -g "${USER}")" -eq "$PGID" ]; then groupmod -o -g "$PGID" "${USER}" ; fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u "${USER}")
User gid:    $(id -g "${USER}")
-----------------------------------
"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading Minecraft";

    manifest=$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json')
    version=$(jq -c ".versions[] | select( .id == \"$MINECRAFT_VERSION\" )" <<< "$manifest")
    version_manifest=$(curl -s "$(jq -r ".url" <<< "$version")")

    server_url=$(jq -r '.downloads.server.url' <<< "$version_manifest")

    curl -o "$JAR_NAME" -J "$server_url"
fi

echo "Accepting EULA"
echo "eula=true" > eula.txt

chown -R "${USER}":"${USER}" /minecraft


COMMAND="${*:-"cd /minecraft; $(which java) ${JAVA_OPTS} -jar $JAR_NAME nogui"}"

su -l "${USER}" -c "$COMMAND"
