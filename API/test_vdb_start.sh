#!/bin/bash

#########################################################
## Subroutines ...

source ./jqJSON_subroutines.sh

#########################################################
## Parameter Initialization ...

. ./delphix_engine.conf

#########################################################


#Below variables are fixed, no need to modify
BNAME=snapsyc-$(date +%Y-%m-%d-%H-%M-%S)
export BNAME


#########################################################

## Connect to the Delphix Engine
echo
echo
echo "Create session"
curl -s -X POST -k --data @- ${BaseURL}/session -c ~/cookies.txt -H "Content-Type: application/json" <<EOF
{
    "type": "APISession",
    "version": {
        "type": "APIVersion",
        "major": 1,
        "minor": 9,
        "micro": 0
    }
}
EOF
echo
echo
echo "Authenticating on ${BaseURL}"
echo
RESULTS=$( RestSession "${DMUSER}" "${DMPASS}" "${BaseURL}" "${COOKIE}" "${CONTENT_TYPE}" )
echo "Results: ${RESULTS}"
if [ "${RESULTS}" != "OK" ]
then
   echo "Error: Exiting ..."
   exit 1;
fi
echo
echo "Session and Login Successful ..."

#########################################################
#
# Command Line Arguments ...
#
SOURCE_SID=$1
export SOURCE_SID

echo "Source: ${SOURCE_SID}"

#########################################################


# Start VDB
echo
echo
STATUS=`curl -s -X  POST -k --data @- ${BaseURL}/source/ORACLE_VIRTUAL_SOURCE-24/start \
 -b ~/cookies.txt -H "Content-Type: application/json" <<EOF2
{
    "type": "OracleStartParameters"
}
EOF2
`
echo
echo

#########################################################
#
# Get Job Number ...
#
JOB=$( jqParse "${STATUS}" "job" )
echo "Job: ${JOB}"

jqJobStatus "${JOB}"            # Job Status Function ...

############## E O F ####################################
echo "Done ... VDB Started!"
echo " "
exit 0;




