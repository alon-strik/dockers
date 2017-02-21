#!/bin/bash -e

LOGFILE=/var/log/update-war.log
exec 6>&1           # Link file descriptor #6 with stdout.
exec > $LOGFILE

function error_exit
{
    echo ""
    echo 'LMS: Error update war file, ' $1

    if [[ -e "$restoreWar" ]]; then
         echo 'LMS: Restoring old war file'
         sudo cp $restoreWar /opt/lms/apache-tomcat-7/webapps/${WARNAME}.war
    fi

    sudo /etc/init.d/tomcat7 start > /dev/null
    sudo service monit start > /dev/null
    sudo service cron start > /dev/null

    exec 1>&6 6>&-
    exit 1
}

function error_fatal
{
    exec 1>&6 6>&-
    exit 1
}

function validateWar
{
    echo "LMS: Validate war in : ${bucketPath} "
    WAR_STATUS=$(aws s3 ls ${WARFULLPATH})

    if [ -z "$WAR_STATUS" ]; then
        echo "LMS: War file does not exist in the new location, ${bucketPath}"
        error_fatal
    fi
}

function getStatus
{
    echo 'LMS: Get status.'
    resp=$(curl -s --retry 3 http://localhost:8080/lms/v1/system/status | grep uptime)
    if [[ -z  "${resp}" ]]; then
        echo '%%ERROR%%: get status failed. Tomcat must be available.(getStatus) '
        error_fatal
    fi
}

function getVersion
{
    echo 'LMS: Get version..'
    resp=$(curl -s --retry 3 http://localhost:8080/lms/v1/system/version | grep version)
    if [[ -z  "${resp}" ]]; then
        echo '%%ERROR%%: get status failed. Tomcat must be available.(getVersion) '
        error_fatal
    fi
}


bucketPath=$1
WARNAME="lms"

echo 'LMS: ---- Start Update ---- '  `date`

if [ -z "${bucketPath}"  ]; then
   echo "LMS: No bucket name, War will not be updated, keeping original war file.."
   echo 'LMS: ---- Update Done  ---- '  `date`
   error_fatal
fi

WARFULLPATH="s3://${bucketPath}/${WARNAME}.war"
validateWar

echo 'LMS: Full WAR path : ' $WARFULLPATH

LMS_HOME=/opt/lms
now=$(date +"%Y-%m-%d-%H-%M")

getStatus
getVersion
echo 'LMS: Current version to upgrade  = ' $resp

echo 'LMS: Backup original '${WARNAME}'.war file, /opt/lms/'${WARNAME}'.war.original.'${now}
sudo cp ${LMS_HOME}/apache-tomcat-7/webapps/${WARNAME}.war /opt/lms/${WARNAME}.war.original.${now} || error_exit "File not found on destination for backup"
restoreWar=/opt/lms/${WARNAME}.war.original.${now}

# Stopping Services
sudo service cron stop > /dev/null
sudo service monit stop > /dev/null
while [ -f '/var/run/tomcat.pid' ]; do
      echo 'Stopping tomcat...'
      sudo /etc/init.d/tomcat7 stop > /dev/null
done

sudo rm -rf ${LMS_HOME}/apache-tomcat-7/webapps/${WARNAME}
sudo rm -f ${LMS_HOME}/apache-tomcat-7/webapps/${WARNAME}.war

cd ${LMS_HOME}
echo 'LMS: Downloading new war file : ' ${WARFULLPATH}
sudo aws s3 cp --quiet ${WARFULLPATH}  ${LMS_HOME}/apache-tomcat-7/webapps/${WARNAME}.war  || error_exit "Fail to download war file"

echo 'LMS: Starting tomcat service'
sudo /etc/init.d/tomcat7 start > /dev/null
echo "wait for tomcat to restart..(30 Sec.)";sleep 30

getVersion
echo 'LMS: New version after upgrade = ' $resp

echo 'LMS: restarting  monit keep A live cron job'
sudo service monit start > /dev/null
sudo service cron start > /dev/null

echo 'LMS: ---- Update Done  ---- '  `date`

exec 1>&6 6>&-
