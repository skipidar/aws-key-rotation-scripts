import configparser
import os
import argparse
import json

# see https://alexwlchan.net/2018/12/getting-credentials-for-an-assumed-iam-role/




# @click.command()
# @click.option("--profile_name", required=False)
# def getProfileName(profile_name):
#     if profile_name is None:
#         profile_name = "dev"
#     return click.echo(profile_name)


def getProfileName():
    parser = argparse.ArgumentParser(description='Process the arguments')

    parser.add_argument('--aws_profile_name', default="dev",
                    help='the name of the aws profile')
    args = parser.parse_args()
    return args.aws_profile_name


def getAwsCredentialsConfig():
    aws_dir = os.path.join(os.environ["HOME"], ".aws")

    credentials_path = os.path.join(aws_dir, "credentials")
    # print("Look for credentials in: "+credentials_path)

    config = configparser.ConfigParser()
    config.read(credentials_path)

    return config

def getAccessKey(awsCredentialsConfig, profile_name):
    aws_access_key_id = awsCredentialsConfig.get(profile_name, 'aws_access_key_id')
    return aws_access_key_id

def getSecretKey(awsCredentialsConfig, profile_name):
    aws_secret_access_key = awsCredentialsConfig.get(profile_name, 'aws_secret_access_key')
    return aws_secret_access_key

############## START

# getting the current file
profile_name = getProfileName()
# print("AWS profile name: "+profile_name)

# creating the AWS credentials
config = getAwsCredentialsConfig()
assert profile_name in config.sections()

# reading the profile specific settings
aws_access_key_id = getAccessKey(config, profile_name)
aws_secret_access_key = getSecretKey(config, profile_name)

data = {}
data['profile_name'] = profile_name
data['aws_access_key_id'] = aws_access_key_id
data['aws_secret_access_key'] = aws_secret_access_key

json_data = json.dumps(data)

print(json_data)