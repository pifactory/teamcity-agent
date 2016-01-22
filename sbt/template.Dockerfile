FROM williamyeh/java8
MAINTAINER Alexander Dvorkovyy

ENV TEAMCITY_AGENT_NAME "SBT_Agent"

ENV SBT_VERSION  0.13.8
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

USER teamcity

RUN echo "==> fetch all sbt jars from Maven repo..." \
 && sbt

VOLUME [ "/app" ]
WORKDIR /app

CMD "/teamcity-agents.shs