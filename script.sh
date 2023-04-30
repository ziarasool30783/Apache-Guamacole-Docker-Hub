#!/bin/sh
#
# check if docker is running
if ! (docker ps >/dev/null 2>&1)
then
        echo "docker daemon not running, will exit here!"
        exit
fi
echo "Preparing folder init and creating ./init/initdb.sql"
mkdir ./init >/dev/null 2>&1
mkdir -p ./nginx/ssl >/dev/null 2>&1
chmod -R +x ./init
docker run --rm ziarasool/apache-guamacole:guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql
echo "done"
echo "Creating SSL certificates"
openssl req -nodes -newkey rsa:2048 -new -x509 -keyout nginx/ssl/self-ssl.key -out nginx/ssl/self.cert -subj '/C=PK/ST=Punjab/L=Lahore/O=Systems/OU=IT/CN=www.systemsltd.com/emailAddress=zia.rasool@systemsltd.com'
echo "done"




#Reference
#https://www.ibm.com/docs/en/api-connect/2018.x?topic=overview-generating-self-signed-certificate-using-openssl
#https://hub.docker.com/r/guacamole/guacamole
