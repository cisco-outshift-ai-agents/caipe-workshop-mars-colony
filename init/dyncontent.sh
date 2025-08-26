#!/bin/bash

#replace custom strings in lab

ETIPATH="/usr/share/etilabs"

#these are set/saved by the deployer
CNT=`head -n 1 $ETIPATH/details | tail -1`
LABNAME=`head -n 2 $ETIPATH/details | tail -1`
LABURL=`head -n 3 $ETIPATH/details | tail -1`

TWODIG=$CNT
if [ ${#TWODIG} -lt 2 ] ; then
  TWODIG="0"$TWODIG
fi

#lab title
#sed -i -e "s/%%LABID%%/Station $TWODIG/g" /var/www/html/lab/meta/metadata

#labcontent
#sed -i -e "s|%%LABNAME%%|$LABNAME|g" /var/www/html/lab/201-mission4.html
find /var/www/html/lab -type f -exec sed -i "s|%%LABNAME%%|$LABNAME|g" {} \;
find /var/www/html/lab -type f -exec sed -i "s|%%LABURL%%|$LABURL|g" {} \;


#lab prompt
#sed -i -e "s#outshift>#outshift-lab$TWODIG>#g" /home/ubuntu/.bashrc
