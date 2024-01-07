ARG JAVA_VERSION=17

FROM eclipse-temurin:${JAVA_VERSION}

RUN apt update \
    && apt install -y jq \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" minecraft \
    && addgroup minecraft users

EXPOSE 25565

WORKDIR /minecraft

ENV MINECRAFT_VERSION=1.20.4
ENV NEO_VERSION=20.4.80-beta

ENV JAVA_OPTS="-Xms1G -Xmx2G"

COPY entrypoint.sh /entrypoint.sh
COPY ./set-up-user.sh /usr/local/bin/set-up-user.sh
COPY ./configure-server-properties.sh /usr/local/bin/configure-server-properties.sh

ENTRYPOINT [ "/entrypoint.sh" ]