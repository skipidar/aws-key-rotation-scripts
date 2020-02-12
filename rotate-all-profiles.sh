#!/usr/bin/env bash

set -e

# The profiles should be already declared in ~/.aws/credentials
declare -a awsCredentialProfiles=("profiledev" "profiletest" "profileprod")

## now loop through the profiles
for awsCredentialProfile in "${awsCredentialProfiles[@]}"
do

    echo -e "\Rotating IAM in to $awsCredentialProfile"

    export AWS_PROFILE=$awsCredentialProfile 

    # rotate the key for the given profile
    bash rotate-iam-user-key.sh -u <YOUR_IAM_USER> -p $awsCredentialProfile

done