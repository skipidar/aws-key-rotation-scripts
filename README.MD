# Script to rotate keys in IAM
This script would rotate the IAM keys.
It will also update the rotated keys in the profile within ~/.aws/credentials file.


## Requirements
In each IAM account - there should be only 1 IAM key.

 - install Python3
 - install jq

## Install python dependencies

    pip install -r requirements.py.txt
 


## rotate one specific IAM key for specific profile

    bash rotate-iam-user-key.sh -u <YOUR_IAM_USER> -p <PROFILE_NAME>


## rotate keys for all profiles

	Store in environment variable your IAM user
	`AWS_IAMUSER_TO_ROTATE="your.iam.user@mail.com"`
	
	Store in environment variable your named AWS profiles for rotation
	`AWS_PROFILES_TO_ROTATE="profiledev,profiletest"`

    bash rotate-all-profiles.sh
	
## rotate keys for all profiles and backup the credentials file

	Store in environment variable your named AWS profiles for rotation
	`AWSCR_BACKUP_FOLDER_PATH="/d/backups/.aws/"`

	bash rotate-all-profiles-backupcreds.sh