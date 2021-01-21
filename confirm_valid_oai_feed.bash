#!/bin/bash
# 

PARALLEL=10

parallel --jobs ${PARALLEL} 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=10 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else : ; fi'

