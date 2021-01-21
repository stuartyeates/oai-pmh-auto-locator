#!/bin/bash

DIR=./log
TIMESTAMP=$(date -d "today" +"%Y%m%d%H%M")
LOGBASE=${DIR}/derived_${TIMESTAMP}_ojs
OUTPUT=${LOGBASE}_confirmed.urls
PARALLEL=20

mkdir -p ${DIR}
cat log/*ojs*_confirmed.urls | sort --unique | sort --random-sort | \
	sed 's#\(/[^/]\+/\)oai$##' | \
	uniq | \
	tee ${LOGBASE}_1.log | \
	wget --output-document=- --input-file=- --max-redirect=10 --tries=2 --timeout=10 --no-check-certificate -q | \
	tr '|" ,' '\012' | tr "'" '\012' | grep '^https\?://' | \
	sed 's/#.*//' | \
	sed 's/?.*//' | \
	grep -v '\(\.jpg\|\.png\|\.css\|\.jpeg\|\.js\|\.svg\|\.gif\|\.pdf\)$' | \
	grep -v '/lib/pkp/js/' | \
	grep -v '\(js$\|/wp-content/\|/wp-json/\|/wp-includes/\|www\.w3\.org\)' | \
	./filter_out_common_websites.bash | \
	sed 's#\(/article/.*\|/gateway\.*\|/about.*\|/information.*\|/issue.*\|/\$\$\$call\$\$\$/.*\|/help/view/user/topic/000001\|/oaiWebFeedGatewayPlugin.*\|/user.*\|/login\|/signIn\|/issue.*\|/user/.*\|/search.*\|/journal/.*\|/notification/.*\|/plugin/.*\)#/oai#' | \
	uniq | \
	tee ${LOGBASE}_2.log | \
	./confirm_valid_oai_feed.bash \
	> ${OUTPUT}

exit


