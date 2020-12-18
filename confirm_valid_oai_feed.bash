#!/bin/bash

RESULTS=$(mktemp -d -t results-$(basename $0)-results-XXXXXXXXXX)


while read URL
do
 (
  #FAILURESFILE=$(mktemp --tmpdir=$RESULTS -t failure-XXXXXXX)      
  #RESULTSFILE=$(mktemp --tmpdir=$RESULTS -t result-XXXXXXX)
  #echo "$URL"
  #echo "${URL}?verb=Identify"

  wget --quiet --no-check-certificate -O - "${URL}?verb=Identify" | grep -q "://www.openarchives.org/OAI/2.0/"  
  if [ ${PIPESTATUS[1]} -ne 0 ]; then
    echo $URL > $(mktemp --tmpdir=$RESULTS -t failure-XXXXXXX)
  else
    echo $URL > $(mktemp --tmpdir=$RESULTS -t result-XXXXXXX)
  fi
) &

#sleep 0.1;
sleep 1
done




