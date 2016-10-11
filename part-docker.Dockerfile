
ARG DOCKER_VERSION 1.12.1
ARG DOCKER_SHA256 05ceec7fd937e1416e5dce12b0b6e1c655907d349d52574319a1e875077ccb79
ARG DOCKER_COMPOSE_VERSION 1.8.1

RUN curl -fsSL "https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker \
	&& curl -fsSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose