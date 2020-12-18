#!/bin/bash
# A script to extract feeds from saves searches

DATA=/data/search*/*
TIMESTAMP=$(date -d "today" +"%Y%m%d%H%M")

LOGDIR=./log/
LOG=${LOGDIR}/search_${TIMESTAMP}

for STR in Google Bing Yandex; do
	echo $STR;
	 find ./source_data/ -name "*${STR}*.html" -exec cat '{}' \; | tr '" <>' '\012' | tr "'" '\012' | grep  "^https\?://[^/]\+/" | sed 's#^\(.*=http\(.\+\)\)$#\1\nhttp\2#' | ./filter_out_common_websites.bash | sort --unique | \
		tee >(grep -h '\(/about/aboutThisPublishingSystem\|/user/register\|user/setLocale/NEW_LOCALE\|/about/editorialTeam$\|/about/submissions$\|/about/contact$\|/information/readers$\|/information/authors$\|/information/librarians$\)' | sed 's#\(/[^/]\+/[^/]\+\(?.*\)\?$\)#/oai#' | sort --unique  > ${LOG}_${STR}_ojs_system.urls ) \
		>(grep -h '\(/index.php/\)'| sed 's#/\(index.php/[^/]\+/\).*#/\1oai#'  | sort --unique  > ${LOG}_${STR}_ojs_system2.urls ) \
		>(grep -h '\(/article/downloadSuppFile/\|/article/viewFile/\|/article/download/\)'  | sort --unique  > ${LOG}_${STR}_ojs_files.urls ) \
		>(grep -h '\(/handle/\)'| sed 's#/handle/.*#/oai/request#'  | sort --unique  > ${LOG}_${STR}_dspace_handle.urls ) \
		>(grep -h '\(/xmlui/handle/\|/jspui/handle/\)'| sed 's#/[^/]\+/handle/.*#/oai/request#'  | sort --unique  > ${LOG}_${STR}_dspace_handle2.urls ) \
		>(grep -h '\(/xmlui/bitstream/handle/\|/jspui/bitstream/handle/\)'| sed 's#/[^/]\+/[^/]\+/handle/.*#/oai/request#'  | sort --unique  > ${LOG}_${STR}_dspace_handle3.urls ) \
		> ${LOG}_${STR}_all.urls  \
		| cat /dev/null
		
done

exit

 
