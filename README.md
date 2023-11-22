# [anthonyporthouse/minecraft-server](https://github.com/anthonyporthouse/minecraft-server)

## Tags

The major tags determine which version of java you will be using to run minecraft.

- `java8`
- `java11`
- `java16`
- `java17`

## Usage

### docker-compose

Example `docker-compose.yaml` file:

```yaml
---
services:
  minecraft:
    image: ghcr.io/anthonyporthouse/minecraft-server:java17

    restart: unless-stopped

    environment:
      PUID: 1000
      PGID: 1000

      MINECRAFT_VERSION: 1.20.2
      JAVA_OPTS: -Xms1G -Xmx2G

      MC_DIFFICULTY: hard
      MC_MOTD: My Server
    
    ports:
      - "25565:25565"
    
    volumes:
      - ./server:/minecraft

```

### Environment Variables

To make this image more useful several environment variables are available to use.

**`PUID`**

> Default Value: `1000`

This environment variable specifies the ID to use for the minecraft user inside of the container.

This should map to the current users UID which can be found using `id -u` on Linux or Mac.

**`PGID`**

> Default Value: `1000`

This environment variable specifies the ID to use for the minecraft group inside of the container.

This should map to the current users GID which can be found using `id -g` on Linux or Mac.

**`MINECRAFT_VERSION`**

> Default Value: `1.20.2`

This environment variable specifies which version of Minecraft you wish to run. This can be any version supported, either stable or prerelease.

If this is changed after an initial run the container will pull the new version and use that.

**`JAVA_OPTS`**

> Default Value: `-Xms1G -Xmx2G`

This environment variable allows you to specify custom JVM arguments when running minecraft.

**`MC_*`**

Any environment variable that is prefixed with `MC_` will have its prefix removed, be lowercased and have any `_` replaced with `-` then be either replaced, or appended to the `server.properties` file.

Example: `MC_MAX_PLAYERS` with value `10` sets the value of `max-players=10` in the `server.properties` file.
