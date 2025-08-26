#!/bin/bash

ETIPATH="/usr/share/etilabs"

CNT=`head -n 1 $ETIPATH/details | tail -1`
LABNAME=`head -n 2 $ETIPATH/details | tail -1`
LABURL=`head -n 3 $ETIPATH/details | tail -1`

#in case there is some additional file with keys, accounts, read the $CNT line. File should be in this same directory
#LINE=`head -n $CNT $ETIPATH/labinit/update/content/init/accounts | tail -1`
#set $LINE
#rm -f $ETIPATH/labinit/update/content/init/accounts

# additional nginx config
#sudo cp -f $ETIPATH/labinit/update/content/init/rag /etc/nginx/paths
sudo cp -f $ETIPATH/labinit/update/content/init/nginx_rag /etc/nginx/sites-enabled
sudo cp -f $ETIPATH/labinit/update/content/init/nginx_idpbuilder /etc/nginx/sites-enabled
sudo cp -f $ETIPATH/labinit/update/content/init/nginx_vault /etc/nginx/sites-enabled

sudo nginx -s reload

sudo apt-get update && sudo apt-get install -y gpg lsb-release
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y vault
