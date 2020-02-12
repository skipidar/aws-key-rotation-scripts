# Script to rotate keys in IAM
This script would rotate the IAM keys.
It will also update the rotated keys in the profile within ~/.aws/credentials file.


## Requirements
In each IAM account - there should be only 1 IAM key.

 - install Python3
 - install jq

## Install python dependencies

    pip install -r requirements.py.txt

## update rotate-all-profiles.sh
Set <YOUR_IAM_USER> in rotate-all-profiles.sh

Set "awsCredentialProfiles" in rotate-all-profiles.sh



## rotate one specific IAM key for specific profile

    bash rotate-iam-user-key.sh -u <YOUR_IAM_USER> -p <PROFILE_NAME>


## rotate keys for all profiles

    bash rotate-all-profiles.sh