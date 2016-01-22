
## START COMMON PART

# Build arguments, do not use in container.
# Will be converted to ARG once Docker Hub migrates to 1.9
ENV TEAMCITY_VERSION 9.1.5
ENV AGENT_DIR /opt/buildAgent
ENV AGENT_HOME /home/teamcity

ADD teamcity-agent.sh /teamcity-agent.sh

RUN apt-get update \
 && apt-get install -y curl git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p $AGENT_DIR \
 && addgroup --system --gid 990 teamcity \
 && adduser --system --uid 990 --gid 990 --home $AGENT_HOME --shell /bin/false teamcity \
 && chown teamcity:teamcity $AGENT_DIR \
 && sed -i 's#%AGENT_DIR%#'$AGENT_DIR'#' /teamcity-agent.sh \
 && chmod +x /teamcity-agent.sh

#
# Docker
#

# Build arguments, do not use in container.
# Will be converted to ARG once Docker Hub migrates to 1.9
ENV DOCKER_VERSION 1.9.1

RUN curl -fsSL "https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
	&& echo "52286a92999f003e1129422e78be3e1049f963be1888afc3c9a99d5a9af04666  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

WORKDIR $AGENT_DIR
VOLUME $AGENT_HOME
VOLUME $AGENT_DIR

# Environment variables, safe to change in container
ENV TEAMCITY_AGENT_PORT 9090
ENV TEAMCITY_SERVER "http://teamcity:8111"

EXPOSE $TEAMCITY_AGENT_PORT

## END COMMON PART
