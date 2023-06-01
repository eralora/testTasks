#!/bin/bash



#Declare varibales to store information about LAST modified file in appropriate FOLDER.
fName=""
fSize=""
fDate=""
fPath=""

#Declare variables which hold neccessary PATHs

filePath="/tmp/test/files"
logPath="/tmp/test/script-log/sync.log"
archPath="/tmp/test/archives"

#Checking that Last Modified file is NOT older than 7 days
dateCheck=`find ${filePath} -type f -mtime -7 -print`
#Declareing variables which store File path, date, name and size
if [[ -n ${dateCheck} ]]; then
  fName=$(ls ${filePath} -Art1 | tail -n 1)
  fPath=$(readlink -f ${filePath}/${fName})
  fSize=$(stat -c%s ${fPath})
  fDate=$(stat -c '%y' ${fPath})
fi

#Add this info to synс.log file using varibales and rediraction >>
echo "Name="${fName} "Size="${fSize} "Date="${fDate} "Path="${fPath} >> ${logPath}

#Creating Archive .tar.gz of this file + date and time of creating this archive
dateTime=`date +'%Y%m%d%H%M'`
tar -czvf ${fName}-${dateTime}.tar.gz ${filePath}/${fName}

#Move archieve to /tmp/test/archives

mv ${fName}-${dateTime}.tar.gz ${archPath}


#Check that you have succefully moved archive. If yes delete original file

if [ $? -eq 0 ]; then
  rm ${filePath}/${fName}
fi


#Run script Every day and every 15 minutes. 
#Here I am going to use cronjob. 


