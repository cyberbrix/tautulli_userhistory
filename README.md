# plexpy_userhistory
#A linux bash script to provide user watch history, similiar to plexWatch, for PlexPy. It provdies history for all users for the previous day. Only users with activity will be displayed. First movies, then TV episodes.

#output is text, so it can be redirected
#Example output
#User1
#Movie1 (year) - [70%]
#
#Show1 - Title - s01e01 [77%]
#

#After cloning the repository, perform the following, if needed
#cd plexpy_userhistory/
#chmod a+x plexpy_userhistory.sh

#Run in bash, requires jq

#https://stedolan.github.io/jq/

#Create a .plexpy_userhistory.ini in users $HOME directory

#.plexpy_userhistory.ini contents should be followling lines.

ipaddress="<PLEXYPY IP ADDRESS>"

port="<PLEXPY Port>"

plexpyapi="<PLEXPY API>"
