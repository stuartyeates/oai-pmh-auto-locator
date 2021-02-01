#!/bin/bash
# transform a stream of random URLs into a stream of OAI-PMH candidate URLs



(tee >(grep -h '\(/about/aboutThisPublishingSystem\|/user/register\|user/setLocale\|/about/editorialTeam$\|/about/submissions$\|/about/contact$\|/information/readers$\|/information/authors$\|/information/librarians$\|/issue/\)' | sed 's#\(/[^/]\+/[^/]\+\(?.*\)\?$\)#/oai#' | uniq ) \
		>(grep -h '\(user/setLocale\)' | sed 's#\(/[^/]\+/[^/]\+/[^/]\+\(?.*\)\?$\)#/oai#' | uniq ) \
		>(grep -h '\(/index.php/[^/]\+/\)'| sed 's#/\(index.php/[^/]\+/\).*#/\1oai#'  | uniq ) \
		>(grep -h '\(/article/downloadSuppFile/\|/article/viewFile/\|/article/download/\|/article/view/\)' |  sed 's#\(/article/downloadSuppFile/\|/article/viewFile/\|/article/download/\|/article/view/\).*#/oai#' | uniq  ) \
		>(grep -h '\(/handle/\)'| sed 's#/handle/.*#/oai/request#' | uniq ) \
		>(grep -h '\(/xmlui/handle/\|/jspui/handle/\)'| sed 's#/[^/]\+/handle/.*#/oai/request#' | uniq ) \
		>(grep -h '\(/xmlui/bitstream/handle/\|/jspui/bitstream/handle/\)'| sed 's#/[^/]\+/[^/]\+/handle/.*#/oai/request#'  | uniq ) \
		>(grep -h '\(/collect/\)'| sed 's#^\(.\+\)/collect/.*$#\1/cgi-bin/oaiserver.cgi\n\1/oaiserver.cgi#' | uniq ) \
		>(grep -h '[^0-9]/[1-9][0-9]*/[0-9]/[^/]*.pdf$' | sed '#\([^0-9]\)/[1-9][0-9]*/[0-9]/[^/]*.pdf#\1/cgi/oai2#' | uniq  ) \
		>(grep -h '[^0-9]/[1-9][0-9]*/\?$'| sed 's#\([0-9]\)/[1-9][0-9]*/\?$#\1/cgi/oai2#'  | uniq  ) \
		> /dev/null
) > output	
 
