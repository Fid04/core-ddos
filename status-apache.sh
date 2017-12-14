#!/bin/bash

#echo "" > /tmp/apache.dat 
printf "status\tctime\t\trtime\t\tuptime\tmemoria\tcpu\ttacc\ttkb\n" > /tmp/apache.dat 

for x in `seq 1 1 305`
do

# monit
lynx -dump -error_file=/tmp/x$$ http://192.168.42.65:2812 &>/dev/null
MONIT=`awk '/STATUS/{print $2}' /tmp/x$$ 2>/dev/null`
if [ $? != 0 ]; then
   	echo "site is down"
        STATUS=`echo 0 | awk '{printf "%s\t", $1}'`
        MEM=`echo 0 | awk '{printf "%s\t", $1}'`
        CPU=`echo 0 | awk '{printf "%s\t", $1}'`
        UPTIME=`uptime`
else
      MONIT=$(lynx -dump http://192.168.42.65:2812 2>&1 | grep '\[7]') 
      
      STATUS=`echo $MONIT | awk '{print $2}'`
      if [ $STATUS = "OK" ]
      then 
          STATUS=`echo 1 | awk '{printf "%s\t", $1}'`
          MEM=`echo $MONIT | awk '{printf "%s\t", $6}'`
	  CPU=`echo $MONIT | awk '{printf "%s\t", $5}'`
      else
          STATUS=`echo 0 | awk '{printf "%s\t", $1}'`
          MEM=`echo 0 | awk '{printf "%s\t", $1}'`
	  CPU=`echo 0 | awk '{printf "%s\t", $1}'`
      fi
      
	# echo '' >> svstatus.dat && 
	SRVSTATUS=$(lynx -dump http://192.168.42.65/server-status?auto 2>&1) # | grep Load | awk '{print $2}' | perl -p -e 's/\n/ $2/')

	UPTIME=`printf %s "$SRVSTATUS" | grep '[U]ptime' | tail -n 1 | awk '{printf "%s\t", $2}'`
	TACC=`printf %s "$SRVSTATUS" | grep '[T]otal' | grep -m1 -e "Acc" | awk '{printf "%s\t", $3}'`
	TKB=`printf %s "$SRVSTATUS" | grep '[T]otal' | grep -m1 -e "kB" | awk '{printf "%s\t", $3}'`
	CTIME=`printf %s "$SRVSTATUS" | grep '[T]ime' | grep -m1 -e "Curr" | awk '{printf "%s\t", $4}'`
	RTIME=`printf %s "$SRVSTATUS" | grep '[T]ime' | grep -m1 -e "Rest" | awk '{printf "%s\t", $4}'`

        echo "$CTIME$MONIT" >> /tmp/monit.dat
        
fi
 echo "$STATUS$CTIME$RTIME$UPTIME$MEM$CPU$TACC$TKB" >> /tmp/apache.dat
sleep 1
done
