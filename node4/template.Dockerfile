FROM node:4
MAINTAINER Alexander Dvorkovyy

## JDK

## Docker

## Teamcity

#
# Node stuff
#

RUN npm install -g bower grunt-cli

ENV TEAMCITY_AGENT_NAME "NodeJS_Agent"

USER teamcity

CMD "/teamcity-agent.sh"