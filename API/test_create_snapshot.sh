

# Below Variables may change, make sure you have the proper values:
ENGINEURL=landsharkengine
export ENGINEURL
USR=delphix_admin
export USR
PASS=landshark
export PASS
CONT_REFERENCE=ORACLE_DB_CONTAINER-27
export CONT_REFERENCE





#Below variables are fixed, no need to modify
BNAME=snapsyc-$(date +%Y-%m-%d-%H-%M-%S)
export BNAME




## Connect to the Delphix Engine
echo
echo
echo "Create session"
curl -s -X POST -k --data @- ${ENGINEURL}/resources/json/delphix/session \
    -c ~/cookies.txt -H "Content-Type: application/json" <<EOF
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
echo "Logon as:" ${USR}/${PASS}
curl -s -X POST -k --data @- ${ENGINEURL}/resources/json/delphix/login \
    -b ~/cookies.txt -c "cookies.txt" -H "Content-Type: application/json" <<EOF1
{
    "type": "LoginRequest",
    "username": "${USR}",
    "password": "${PASS}"
}
EOF1




# Create Bookmark on Template
echo
echo
echo
echo
curl -s -X  POST -k --data @- ${ENGINEURL}/resources/json/delphix/database/ORACLE_DB_CONTAINER-27/sync \
 -b ~/cookies.txt -H "Content-Type: application/json" <<EOF2
{
    "type": "OracleSyncParameters"
}
EOF2

