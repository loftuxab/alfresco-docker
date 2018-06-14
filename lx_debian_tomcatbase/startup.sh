#!/bin/bash
# -------
# Script for starting/stopping Alfresco Tomcat
#
# Copyright 2013-2018 Loftux AB, Peter Löfgren
# Distributed under the Creative Commons Attribution-ShareAlike 3.0 Unported License (CC BY-SA 3.0)
# -------

export CATALINA_OUT=$CATALINA_HOME/logs/catalina.out
export CATALINA_TMPDIR=/$CATALINA_HOME/temp

# IMPORTANT Update to match memory available on your server.
# For production, A server with at least 8G ram, and -Xmx6G is recommended. More is better!

JAVA_OPTS=$TOMCAT_MEM

# Below are options that can be used for dealing with memory and garbage collection
# JAVA_OPTS="${JAVA_OPTS} -Xss1024k -XX:MaxPermSize=256m -XX:NewSize=512m -XX:+CMSIncrementalMode -XX:CMSInitiatingOccupancyFraction=80"

JAVA_OPTS="${JAVA_OPTS} ${TOMCAT_REGION}"
# Enable this if you encounter problems with transformations of certain pdfs. Side effect is disable of remote debugging
# JAVA_OPTS="${JAVA_OPTS}  -Djava.awt.headless=true"

# Enable if you wish to speed up startup
# Possibly less secure random generation see http://wiki.apache.org/tomcat/HowTo/FasterStartUp#Entropy_Source
JAVA_OPTS="${JAVA_OPTS}  -Djava.security.egd=file:/dev/./urandom"

# set tomcat temp location
JAVA_OPTS="${JAVA_OPTS} -Djava.io.tmpdir=${CATALINA_TMPDIR}"

#File encoding may be correct, but we specify them to be sure
JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
JAVA_OPTS="${JAVA_OPTS} -Dalfresco.home=${ALF_HOME} -Dcom.sun.management.jmxremote=true"
JAVA_OPTS="${JAVA_OPTS} -server"

export JAVA_OPTS

# Copy default files if default not present. If mounted, it only needs this once and you can setup
if [ "$(ls -A $CATALINA_HOME/shared)" ]; then
    echo "** Tomcat shared exists **"
else
    echo "** Copying shared default to Tomcat shared **"
    cp -r $CATALINA_HOME/shareddefault/* $CATALINA_HOME/shared/
fi

echo "** Starting Tomcat **"

# First cd to logs directory so alfresco.log end up there
cd ${ALF_HOME}/logs

${JAVA_HOME}/bin/java $JAVA_OPTS \
-Djava.util.logging.config.file=${CATALINA_HOME}/conf/logging.properties \
-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager \
-Djdk.tls.ephemeralDHKeySize=2048 \
-Djava.protocol.handler.pkgs=org.apache.catalina.webresources \
-Dorg.apache.catalina.security.SecurityListener.UMASK=0027 \
-Dignore.endorsed.dirs= -classpath ${CATALINA_HOME}/bin/bootstrap.jar:${CATALINA_HOME}/bin/tomcat-juli.jar \
-Dcatalina.base=${CATALINA_HOME} \
-Dcatalina.home=${CATALINA_HOME} \
-Djava.io.tmpdir=${CATALINA_TMPDIR} \
org.apache.catalina.startup.Bootstrap start