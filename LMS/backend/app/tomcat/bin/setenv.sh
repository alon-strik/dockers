#!/bin/sh

#export LMS_HOME="/usr/local/tomcat"
#export JAVA_OPTS="$JAVA_OPTS -Dlms.home=$LMS_HOME"
export CATALINA_PID="/var/run/tomcat.pid"

JAVA_OPTS="$JAVA_OPTS -Dlms_env=prod"

# export CATALINA_OPTS="-Dlogback.configurationFile=${LMS_HOME}/conf/logback.xml \
# -Dorg.apache.catalina.startup.TldConfig.jarsToSkip=* \
# -Dcom.sun.management.jmxremote \
# -Dcom.sun.management.jmxremote.ssl=false \
# -Dcom.sun.management.jmxremote.authenticate=false \
# -Djava.rmi.server.hostname={MGMT-IP} \
# -Dcom.sun.management.jmxremote.port=12001 \
# -Dcom.sun.management.jmxremote.rmi.port=12002"

export JAVA_OPTS
