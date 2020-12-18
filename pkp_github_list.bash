#!/bin/bash

DIR=./log
TIMESTAMP=$(date -d "today" +"%Y%m%d%H%M")
LOGBASE=${DIR}/list_${TIMESTAMP}_pkp_ojs
OUTPUT=${DIR}/pkp_github_list_${DATE}_confirmed.urls

mkdir -p ${DIR}

wget --output-document=- -q https://raw.githubusercontent.com/pkp/ojsstats/master/Playing%20with%20asyncio.ipynb | \
 	tr '|" ,' '\012' | grep "^http" | sed 's#\\n$##' | grep "/oai" | \
	sed 's#\(.*\)/index.php/index/oai$#\1/|\1/index.php|\1/index.php/index#' | \
	sed 's#\(.*\)/index/oai$#\1/|\1/index/#' | tr '|' '\012' | \
	sed 's/#.*//' | \
	tee ${LOGBASE}_1.log | \
	parallel --jobs 20 wget --output-document=- --input-file=- --max-redirect=10 --tries=2 --timeout=20 --no-check-certificate -q | \
	tr '|" ,' '\012' | tr "'" '\012' | grep '^http' | \
	sed 's#/lib/pkp/js/.*#/lib/pkp/js/#' | \
	grep -v '\(js^\|wp-content\|wp-json\|wp-includes\|google\.com\|blogspot\.com\|www\.w3\.org\)' | \
	sort --unique | \
	sed 's#\(/article/view/.*$\|/gateway/plugin/\|/about/aboutThisPublishingSystem\|/about/privacy\|/information/librarians\|/issue/archive\|/issue/current\|/\$\$\$call\$\$\$/.*\|/help/view/user/topic/000001\|/oaiWebFeedGatewayPlugin/.*\|/information/authors\|/information/readers\|/about/submissions\)#/oai#' | \
	sed '/oai$/! s#\(?.*\)\?$#/oai#' | \
	tee ${LOGBASE}_2.log \
	| sort --unique  | sort --random-sort | \
	parallel --jobs 55555 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' | \
	grep '^http' | sort --unique  \
	> ${OUTPUT}

exit


