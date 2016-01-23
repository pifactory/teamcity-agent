FROM docker
MAINTAINER Alexander Dvorkovyy

## Teamcity

## JDK

ENV TEAMCITY_AGENT_NAME "Docker_Agent"

USER teamcity

CMD "/teamcity-agent.sh"