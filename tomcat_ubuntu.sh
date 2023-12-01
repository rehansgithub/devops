#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y
sudo apt install tomcat9 tomcat9-admin tomcat9-docs tomcat9-common git -y

sudo apt install awscli -y

# AWS Access Key ID and Secret Access Key
export AWS_ACCESS_KEY_ID="AKIAZMRO4RQVTQZ5BPU6"
export AWS_SECRET_ACCESS_KEY="iK+EkUSUHvovMoMi8IUxBKtw3OUW7uCz6ndVAdx/"

# AWS Session Token (if using temporary credentials)
# export AWS_SESSION_TOKEN="YOUR_SESSION_TOKEN"

# AWS Default Region
export AWS_DEFAULT_REGION="us-east-1"  # Replace with your desired region

# AWS Default Output Format
export AWS_DEFAULT_OUTPUT="json"  # Replace with "json" or "text" as desired

sudo -i
systemctl stop tomcat9
aws s3 cp s3://vprofile-buck3t/vprofile-v2.war /tmp
rm -rf /var/lib/tomcat9/webapps/ROOT
cp /tmp/vprofile-v2.war /var/lib/tomcat9/webapps/ROOT.war
systemctl start tomcat9


