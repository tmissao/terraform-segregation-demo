#!/bin/bash

set -x
echo "#########################################################################################"
echo "#                       Stating Installing Docker                                       #"
echo "#########################################################################################"
amazon-linux-extras install docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

echo "#########################################################################################"
echo "#                       Stating Server                                                  #"
echo "#########################################################################################"

docker run -d --restart=unless-stopped \
  -p 80:80 nginx
  
echo "#########################################################################################"
echo "#                             Logs                                                      #"
echo "#########################################################################################"

echo "HELLO FROM EC2 ----> SETUP FINISHED!!!" > logs.txt
aws s3 cp logs.txt s3://${S3_BUCKET}/logs.txt