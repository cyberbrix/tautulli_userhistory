# tautulli_userhistory
#A linux bash script to provide user watch history, for Tautulli. It provdies history for all users for the previous day. Only users with activity will be displayed. First movies, then TV episodes.

#output is text, so it can be redirected
#Example output

#User1
#
#Movie1 (year) - [70%]
#
#Show1 - Title - s01e01 [77%]
#
#After cloning the repository, perform the following, if needed
#cd tautulli_userhistory/
#chmod a+x tautulli_userhistory.sh

#Run in bash, requires jq

#https://stedolan.github.io/jq/

#Create a .tautulli_userhistory.ini in users $HOME directory

#.tautulli_userhistory.ini contents should be followling lines.

httpprotocol="`<http or https`>"

ipaddress="`<tautulli IP ADDRESS`>"

port="`<tautulli Port`>"

tautulliapi="`<tautulli API`>"
