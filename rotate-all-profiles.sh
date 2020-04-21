#!/usr/bin/env bash

set -e

# Required env variables
# AWS_IAMUSER_TO_ROTATE="your.iam.user@mail.com"
# AWS_PROFILES_TO_ROTATE="profiledev,profiletest"



if [ ! -z "${AWS_PROFILES_TO_ROTATE}" ]; then
	echo "Rotating for IAM user $AWS_IAMUSER_TO_ROTATE"
else
	echo "Set AWS IAM user by setting the environment variable AWS_IAMUSER_TO_ROTATE"
	exit 1
fi


# The profiles should be already declared in ~/.aws/credentials and added to AWS_PROFILES_TO_ROTATE env variable
if [ ! -z "${AWS_PROFILES_TO_ROTATE}" ]; then
	echo "Variable is set - get profiles from there"
	IFS=', ' read -r -a array <<< "$AWS_PROFILES_TO_ROTATE"
else
	echo "Env variable 'AWS_PROFILES_TO_ROTATE' MUST contain AWS named profiles for cred rotation."
	exit 1
fi


## now loop through the profiles
for awsCredentialProfile in "${array[@]}"
do

    echo -e "\Rotating IAM in to $awsCredentialProfile"

    export AWS_PROFILE=$awsCredentialProfile 

    # rotate the key for the given profile
    bash rotate-iam-user-key.sh -u $AWS_IAMUSER_TO_ROTATE -p $awsCredentialProfile

done