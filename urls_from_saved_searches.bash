#!/bin/bash
# A script to extract feeds from saves searches

DATA=/data/search*/*
TIMESTAMP=$(date -d "today" +"%Y%m%d%H%M")

LOGDIR=./log/
LOG=${LOGDIR}/search_${TIMESTAMP}

for STR in Google Bing Yandex; do
	echo $STR;
	 find ./source_data/ -name "*${STR}*.html" -exec cat '{}' \; | tr '" <>' '\012' | tr "'" '\012' | grep  "^https\?://" | ./filter_out_common_websites.bash | sed 's#^\(.*=http\(.\+\)\)$#\1\nhttp\2#' | sort --unique | \
		tee >(grep -h '\(/about/aboutThisPublishingSystem\|/user/register\|user/setLocale\|/about/editorialTeam$\|/about/submissions$\|/about/contact$\|/information/readers$\|/information/authors$\|/information/librarians$\)' | sed 's#\(/[^/]\+/[^/]\+\(?.*\)\?$\)#/oai#' | sort --unique  | tee ${LOG}_${STR}_ojs_system.urls | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >  ${LOG}_${STR}_ojs_system_confirmed.urls ) \
		>(grep -h '\(/index.php/\)'| sed 's#/\(index.php/[^/]\+/\).*#/\1oai#'  | sort --unique  | tee ${LOG}_${STR}_ojs_system2.urls | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >  ${LOG}_${STR}_ojs_system2_confirmed.urls  ) \
		>(grep -h '\(/article/downloadSuppFile/\|/article/viewFile/\|/article/download/\|/article/view/\)' |  sed 's#\(/article/downloadSuppFile/\|/article/viewFile/\|/article/download/\|/article/view/\).*#/oai#'   | sort --unique | tee ${LOG}_${STR}_ojs_files.urls | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >  ${LOG}_${STR}_ojs_files_confirmed.urls  ) \
		>(grep -h '\(/handle/\)'| sed 's#/handle/.*#/oai/request#'  | sort --unique  | tee ${LOG}_${STR}_dspace_handle.urls  | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >  ${LOG}_${STR}_dspace_handle_confirmed.urls) \
		>(grep -h '\(/xmlui/handle/\|/jspui/handle/\)'| sed 's#/[^/]\+/handle/.*#/oai/request#'  | sort --unique  | tee ${LOG}_${STR}_dspace_handle2.urls | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >  ${LOG}_${STR}_dspace_handle2_confirmed.urls) \
		>(grep -h '\(/xmlui/bitstream/handle/\|/jspui/bitstream/handle/\)'| sed 's#/[^/]\+/[^/]\+/handle/.*#/oai/request#'  | sort --unique | tee ${LOG}_${STR}_dspace_handle3.urls |  parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' > ${LOG}_${STR}_dspace_handle3.urls ) \
		>(grep -h '\(/collect/\)'| sed 's#^\(.\+\)/collect/.*$#\1/cgi-bin/oaiserver.cgi\n\1/oaiserver.cgi#'  | sort --unique | tee ${LOG}_${STR}_gsdl_item.urls |  parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >   ${LOG}_${STR}_gsdl_item_confirmed.urls ) \
		>(grep -h '[^0-9]/[1-9][0-9]*/[0-9]/[^/]*.pdf$' | sed '#\([^0-9]\)/[1-9][0-9]*/[0-9]/[^/]*.pdf#\1/cgi/oai2#' | sort --unique | tee  ${LOG}_${STR}_eprints_files.urls | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' > ${LOG}_${STR}_eprints_files_confirmed.urls ) \
		>(grep -h '[^0-9]/[1-9][0-9]*/\?$'| sed 's#\([0-9]\)/[1-9][0-9]*/\?$#\1/cgi/oai2#'  | sort --unique  | tee ${LOG}_${STR}_eprint_item.urls | parallel --jobs 5 'wget --no-check-certificate -O  - -q  {}?verb=Identify  --tries=2 --timeout=20 | grep "http://www.openarchives.org/OAI/2.0/" > /dev/null ; if (( 0 == $? )) ; then echo {} ;  else echo  ; fi' >   ${LOG}_${STR}_eprint_item_confirmed.urls ) \
		> ${LOG}_${STR}_all.urls  \
		| cat /dev/null
		
done

exit

 
