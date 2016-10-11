
ARG AGENT_DIR=/opt/buildAgent
ARG AGENT_HOME=/home/teamcity

ADD teamcity-agent.sh /teamcity-agent.sh

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
