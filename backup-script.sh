#!/bin/bash
time=$(date +%m-%d-%y_%H_%M_%S)
Backup_file=/home/ubuntu/bash
Dest=/home/ubuntu/Backup
filename=file-backup-$time.tar.gz
LOG_FILE="/home/ubuntu/Backup/logfile.log"

s3_bucket="s3-new-bash-course-1735078856"
FILE_TO_UPLOAD="$Dest/$filename"


#if [ -z "$Backup_file"  ]
#then
#    echo "Please, Enter the directory that you want to backup " | tee -a "$LOG_FILE"
#    exit 2
#fi

if ! command -v aws &>/dev/null
then
	echo"AWS CLI not installed. please install it first"
	exit 2 
fi 

if [ $? -ne 2 ]
  then
  if [ -f $filename ]
  then
      echo "Error file $filename already exists!" | tee -a "$LOG_FILE"
  else
      tar -czvf "$Dest/$filename" "$Backup_file" 
      echo "Backup completed successfully. Backup file: $Dest/$filename" | tee -a "$LOG_FILE" 
      echo 
      aws s3 cp "$FILE_TO_UPLOAD" "s3://$s3_bucket/"

  fi
fi

if [ $? -eq 0 ]
then
	echo 
	echo "File Uploaded successfully to the S3 Bucket: $s3_bucket"
else
	echo "File Upload to S3 Bucket Faild."
fi

