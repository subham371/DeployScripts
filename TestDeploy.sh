#!/bin/bash
#!/usr/local/bin/expect -f

# ssh -o 'StrictHostKeyChecking no' $USER@$PUBLIC_IP
echo $USER@$PUBLIC_IP
if [ $CONFIGURE ];
then
echo "true"
ssh -i $KEY_PATH$KEY_NAME $USER@$PUBLIC_IP << EOF
sudo apt-get update
sudo mkdir testdeploy
cd testdeploy
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
yes | sudo apt-get install oracle-java8-installer
sudo wget http://mirror.fibergrid.in/apache/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz
sudo tar -xzvf apache-tomcat-8.5.15.tar.gz
logout
EOF
fi
ssh -i $KEY_PATH$KEY_NAME $USER@$PUBLIC_IP << EOF
cd testdeploy
wget -O apache-tomcat-8.5.15/webapps/$ARTIFACT_NAME $ARTIFACT_URL
echo "download success"
sudo apache-tomcat-8.5.15/bin/startup.sh
logout
EOF
