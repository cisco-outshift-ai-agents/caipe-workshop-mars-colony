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
#sed -i -e "s/%%sometext%%/outshiftlab-user$TWODIG@cisco.com/g" /var/www/html/lab/lab.html

#lab prompt
#sed -i -e "s#outshift>#outshift-lab$TWODIG>#g" /home/ubuntu/.bashrc

