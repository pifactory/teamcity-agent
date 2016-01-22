#!/usr/bin/env bash

for dir in */
do
  cp teamcity-agent.sh $dir

  sed '/MAINTAINER/ r common-part.Dockerfile' $dir'template.Dockerfile' > $dir'Dockerfile'
done