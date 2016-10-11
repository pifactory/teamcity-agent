
ARG DOCKER_VERSION=1.12.1
ARG DOCKER_SHA256=05ceec7fd937e1416e5dce12b0b6e1c655907d349d52574319a1e875077ccb79
ARG DOCKER_COMPOSE_VERSION=1.8.1

RUN curl -fSL "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    	&& tar -xzvf docker.tgz \
    	&& mv docker/* /usr/local/bin/ \
    	&& rmdir docker \
    	&& rm docker.tgz \
    	&& docker -v \
	&& curl -fsSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose