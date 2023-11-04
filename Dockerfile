ARG JAVA_VERSION=17

FROM eclipse-temurin:${JAVA_VERSION}

RUN apt update \
    && apt install -y jq \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 25565

WORKDIR /minecraft

ENV MINECRAFT_VERSION=1.20.2

ENV JAVA_OPTS="-Xms1G -Xmx2G"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]