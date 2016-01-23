FROM docker
MAINTAINER Alexander Dvorkovyy

## JDK

## Teamcity

ENV TEAMCITY_AGENT_NAME "Docker_Agent"

USER teamcity

CMD "/teamcity-agent.sh"