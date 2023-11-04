#! /usr/bin/env bash
set -e

JAR_NAME="server-${MINECRAFT_VERSION}.jar"

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

java ${JAVA_OPTS} -jar "$JAR_NAME" nogui