#!/bin/bash

#Scrape and Define WX Data
TEMP=$(curl --silent "https://w1.weather.gov/data/obhistory/KHPN.html" | \
tail -n +24 | \
head -n +1 | \
awk -F '<td>' '{print $6}' | awk '{gsub(/<\/td>/, "°")} {print}' 2>/dev/null)

FEELTEMP=$(curl --silent "https://w1.weather.gov/data/obhistory/KHPN.html" |\
tail -n +25 |\
head -n +1 |\
awk -F 'td' '$8 !=">NA</" {print $8 "°"} $10 !=">NA</" {print $10 "°"} $8==">NA</" && $10==">NA</" {print "same"}' |\
awk '{sub(/>/,"")} {sub(/<\//,"")} {print $1}' 2>/dev/null)

HUMIDITY=$(curl --silent "https://w1.weather.gov/data/obhistory/KHPN.html" |\
tail -n +25 |\
head -n +1 |\
awk -F '<td>' '{print $4}' |\
awk '{sub(/<\/td>/," Humidity")} {print $1 "," $2","}' 2>/dev/null)

WIND=$(curl --silent "https://w1.weather.gov/data/obhistory/KHPN.html" |\
tail -n +24 |\
head -n +1 |\
awk -F '<td>' '{print $3}' |\
awk '{gsub(/<\/td>/," mph")} $1=="Calm" {print "Calm""," "Wind" "," ""} $1!="Calm" && $3=="G" {print $2 " mph" "," "Wind (" $4 " mph gusts)" "," $1} $1!="Calm" && $3!="G" {{print $2 " mph" "," "Wind" "," $1}}' 2>/dev/null)

#print the data on newlines for the widget to format into columns
if [[ "$FEELTEMP" == "same" ]]
then
  echo $TEMP ",Temperature,Feels Like " $TEMP
else
  echo $TEMP ",Temperature,Feels Like " $FEELTEMP
fi
echo $HUMIDITY
echo $WIND
