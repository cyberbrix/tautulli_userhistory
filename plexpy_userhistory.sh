#!/bin/bash

#change to location if different than below. Should be in user's home directory.
configfile="~/plexpy_userhistory.ini"

#must have JQ installed

#check if JQ installed
if ! type jq &> /dev/null
then echo "jq is not installed"
exit
fi


#default values for variables
ipaddress="NOTSET"
port="NOTSET"
plexpyapi="NOTSET"

#Import variables from config
. $configfile

#Validate variables
if [ "$ipaddress" = "NOTSET" ] || [ "$port" = "NOTSET" ] || [ "$plexpyapi" = "NOTSET" ]
then
echo "variables not set in config file"
exit
fi


#validate api success
apicheck=`curl -s "$ipaddress:$port/api/v2?apikey=$plexpyapi&cmd=get_server_friendly_name" | jq -r ' .response | { answer: .result } |.[]'`

if [ "$apicheck" != "success" ]
then
echo "API check failed. confirm API, IP, PORT"
exit
fi


#Will identify and store the Usernames of all the accounts. Not tested for ids with a space
ids=`curl -s "http://$ipaddress:$port/api/v2?apikey=$plexpyapi&cmd=get_users" | jq -r '.response.data[] | { username } |.[]'`

#calculates yesterdays date in proper syntax
yesterday="$(date -d yesterday '+%Y-%m-%d')"

#Checks each user for usage
for d in $ids
do

#pulls history for user - grouped
watched=`curl -s "http://$ipaddress:$port/api/v2?apikey=$plexpyapi&cmd=get_history&user=$d&grouping=1&start_date=$yesterday"`

#counts how many shows were watched
numtitles=`echo $watched | jq '.response.data.data[].full_title' | wc -l`

if [ $numtitles -gt 0 ]
then
echo "$d"


#inserting movies watched
echo $watched | jq -r '.response.data.data[] | select(.media_type == "movie") | { show: ( .full_title + " -" + " [" + (.percent_complete|tostring) + "%]" ) } | .[]'


#inserting tv shows watched
echo $watched | jq -r '.response.data.data[] | select(.media_type == "episode") | { show: ( .full_title + " - s" +(.parent_media_index|tostring) + "e" + (.media_index|tostring) + " [" + (.percent_complete|tostring) + "%]" ) } | .[]'

echo ""
fi
done
