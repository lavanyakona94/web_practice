#!/bin/bash

# Disk scripts

function disk {

diskFile=/tmp/disk.txt

df | perl -wne 'if(/(\d+)%\s+(.*)/){print "$2 at $1% usage\n" if $1>99}' > $diskFile

if [ -s $diskFile ]
then
        echo "" >> $diskFile
        echo "" >> $diskFile
        df -h `df | perl -wne 'if(/(\d+)%\s+(.*)/){print "$2 at $1 \n"  if $1>98}' | awk '{print $1}'` >> $diskFile
        mail -s "Disk usage on `hostname` Global Eagle ETAS - SA Alert" etassa@osius.com < /tmp/disk.txt
        rm -f /tmp/disk.txt
else
        rm -f /tmp/disk.txt
fi

}

# Memory usage

function memory {

totalMemory=`free -m | awk 'NR==2{print $2}'`
memReading=`free -m | awk 'NR==3{printf "Memory Usage:\n \t %sMB (Used)\n \t %sMB (Total)\n \t Percentage memory in use (%.2f%)\n", $3,'$totalMemory',$3*100/'$totalMemory'}'`
swapReading=`free -m | awk 'NR==4{printf "Memory Usage:\n \t %sMB (Used)\n \t %sMB (Total)\n \t Percentage memory in use (%.2f%)\n", $3,$2,$3*100/$2 }'`
mem=`free -m | awk 'NR==3{printf "Memory Usage: %sMB(Used)/%sMB(Total) %.0f\n", $3,$2,$3*100/'$totalMemory' }' | awk '{print $4}'`
swap=`free -m | awk 'NR==4{printf "Memory Usage: %sMB(Used)/%sMB(Total) %.0f\n", $3,$2,$3*100/$2 }' | awk '{print $4}'`

if [ $mem -gt 95 ]
then
        echo "$memReading" | mail -s "Low memory in `hostname` Global Eagle ETAS - SA Alert" etassa@osius.com
fi

if [ $swap -gt 95 ]
then
        echo "$swapReading" | mail -s "Low swap memory in `hostname` Global Eagle ETAS - SA Alert" etassa@osius.com
fi

}

# Load

function load {

load=`top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' | awk '{printf "%.0f",$3}'`
actualLoad=`top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'`

if [ $load -gt 15 ]
then
        echo "$actualLoad Please verify." | mail -s "High load on `hostname` Global Eagle ETAS - SA Alert" etassa@osius.com
fi

}

disk
memory
load

