#!/bin/bash

ETIPATH="/usr/share/etilabs"

CNT=`head -n 1 $ETIPATH/details | tail -1`
LABNAME=`head -n 2 $ETIPATH/details | tail -1`
LABURL=`head -n 3 $ETIPATH/details | tail -1`

#in case there is some additional file with keys, accounts, read the $CNT line. File should be in this same directory
#LINE=`head -n $CNT $ETIPATH/labinit/update/content/init/accounts | tail -1`
#set $LINE
#rm -f $HOME/accounts
