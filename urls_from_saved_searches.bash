#!/bin/bash
# A script to extract feeds from saves searches

DATA=/data/search*/*

for STR in Google Bing Yandex; do
	echo $STR;
	 find ./source_data/ -name "*${STR}*.html" -exec cat '{}' \; | tr '" <>' '\012' | tr "'" '\012' | grep  "^https\?://[^/]\+/" | ./filter_out_common_websites.bash | sort --unique | \
		tee >(grep -h '\(/about/aboutThisPublishingSystem\|/user/register\|user/setLocale/NEW_LOCALE\|/about/editorialTeam$\|/about/submissions$\|/about/contact$\|/information/readers$\|/information/authors$\|/information/librarians$\)' | sed 's#\(/[^/]\+/[^/]\+$\)#/oai#' | sort --unique  > str_${STR}_ojs_system.urls ) \
		>(grep -h '\(/index.php/\)'| sed 's#/\(index.php/[^/]\+/\).*#/\1oai#'  | sort --unique  > str_${STR}_ojs_system2.urls ) \
		>(grep -h '\(/article/downloadSuppFile/\|/article/viewFile/\|/article/download/\)'  | sort --unique  > str_${STR}_ojs_files.urls ) \
		> str_${STR}_all.urls  \
		| cat /dev/null
		
done

exit

 
