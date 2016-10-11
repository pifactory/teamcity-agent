FROM node:4
MAINTAINER Alexander Dvorkovyy

## Teamcity

ADD teamcity-agent.sh /teamcity-agent.sh

ARG AGENT_DIR=/opt/buildAgent
ARG AGENT_HOME=/home/teamcity

RUN apt-get update \
 && apt-get install -y curl git unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p $AGENT_DIR \
 && addgroup --system --gid 990 teamcity \
 && adduser --system --uid 990 --gid 990 --home $AGENT_HOME --shell /bin/false teamcity \
 && chown teamcity:teamcity $AGENT_DIR \
 && sed -i 's#%AGENT_DIR%#'$AGENT_DIR'#' /teamcity-agent.sh \
 && chmod +x /teamcity-agent.sh

WORKDIR $AGENT_DIR
VOLUME $AGENT_HOME
VOLUME $AGENT_DIR

# Environment variables, safe to change in container
ENV TEAMCITY_AGENT_PORT 9090
ENV TEAMCITY_SERVER "http://teamcity:8111"

EXPOSE $TEAMCITY_AGENT_PORT

## JDK
RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    \
    \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    \
    \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

## Docker

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
#
# Node stuff
#

RUN npm install -g bower grunt-cli

ENV TEAMCITY_AGENT_NAME "NodeJS_Agent"

USER teamcity

CMD ["/teamcity-agent.sh"]
