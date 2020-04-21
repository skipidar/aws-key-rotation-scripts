#!/bin/bash

# Required env variables

# where will you backup credentials after rotation
# AWSCR_BACKUP_FOLDER_PATH="/d/backups/.aws/"



echo "Script rotates the AWS keys for all profiles. To be executed as root"

# requirements
apt-get install -y jq



# now rotate
bash ./rotate-all-profiles.sh


# Backup credentials if ENV variable with path is set
if [ ! -z "${AWSCR_BACKUP_FOLDER_PATH}" ]; then
	echo "'AWSCR_BACKUP_FOLDER_PATH' is not empty. Backup credentials to '${AWSCR_BACKUP_FOLDER_PATH}'"

	timestamp=$(date +%s)
	touch "${AWSCR_BACKUP_FOLDER_PATH}/credentials.rotate"
	mv "${AWSCR_BACKUP_FOLDER_PATH}/credentials.rotate" "${AWSCR_BACKUP_FOLDER_PATH}/credentials.rotate.${timestamp}"
	
	mkdir -p "${AWSCR_BACKUP_FOLDER_PATH}"
	cp -f /root/.aws/credentials "${AWSCR_BACKUP_FOLDER_PATH}/credentials.rotate"
fi


# Copy credentials also to the Vagrant users folder
if [ ! -d "/home/vagrant/.aws/" ]; then
	cp -f /root/.aws/credentials /home/vagrant/.aws/credentials
	chown vagrant:vagrant /home/vagrant/.aws/credentials
fi


echo "DONE"

