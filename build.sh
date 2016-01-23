#!/usr/bin/env bash

for dir in */
do
  cp teamcity-agent.sh $dir

  sed -e '/## JDK/ r part-jdk.Dockerfile' \
   -e '/## Docker/ r part-docker.Dockerfile' \
   -e '/## Teamcity/ r part-teamcity.Dockerfile' \
      $dir'template.Dockerfile' > $dir'Dockerfile'
done