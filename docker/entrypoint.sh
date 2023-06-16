#!/bin/bash

JAVA_ARGS="-javaagent:AppdAgent/javaagent.jar  \
      -Dappdynamics.agent.applicationName=petclinic \
      -Dappdynamics.agent.nodeName=${NODENAME} \
      -Dspring.profiles.active=docker"

java $JAVA_ARGS org.springframework.boot.loader.JarLauncher
