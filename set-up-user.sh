#!/usr/bin/env bash
set -e

# Username/Groupname to use
USER=$1

# Target User ID
PUID=$2

# Target Group ID
PGID=$3

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