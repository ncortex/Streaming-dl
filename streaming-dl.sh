#!/bin/bash

#		Download videos from streamcloud allmyvideos playedto powvideo(ffmpeg required) and vidspot
#		$1 = Video URL
#		By Jose Linares (http://jose-linares.com)
#		Licence: Creative commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) ( http://creativecommons.org/licenses/by-sa/3.0/deed.en)


function amv		
{
	#Save the variables POST
	wget -q $url -q -O temp_page
	
	op=$(cat temp_page | grep '<input type="hidden" name="op" value="' | cut -d "\"" -f6)
	usr_login=$(cat temp_page | grep '<input type="hidden" name="usr_login" value="' | cut -d "\"" -f6)
	id=$(cat temp_page | grep '<input type="hidden" name="id" value="' | cut -d "\"" -f6)
	fname=$(cat temp_page | grep '<input type="hidden" name="fname" value="' | cut -d "\"" -f6)
	referer=$(cat temp_page | grep '<input type="hidden" name="referer" value="' | cut -d "\"" -f6)
	method_free=$(cat temp_page | grep '<input type="hidden" name="method_free" value="' | cut -d "\"" -f6)
	
	echo -e "\033[1;32mDescargando \033[0;34m $id \033[1;36m $fname : \033[1;0m"
	#Download de page WITH the post variables, and get the video url
	wget -q --post-data "op=$op&usr_login=$usr_login&id=$id&fname=$fname&referer=$referer&url=$url&method_free=$method_free" $url -O page
	
	furl=$(cat page | grep '"file" : "http://' | cut -d "\"" -f4)
	
	#Clean and download the video :D
	rm page temp_page 
	
	curl -L -O -C - -# $furl > "$fname"

}


function pt
{
	#Save the variables POST
	wget $url -q -O temp_page
	
	op=$(cat temp_page | grep '<input type="hidden" name="op" value="' | cut -d "\"" -f6)
	usr_login=$(cat temp_page | grep '<input type="hidden" name="usr_login" value="' | cut -d "\"" -f6)
	id=$(cat temp_page | grep '<input type="hidden" name="id" value="' | cut -d "\"" -f6)
	fname=$(cat temp_page | grep '<input type="hidden" name="fname" value="' | cut -d "\"" -f6)
	referer=$(cat temp_page | grep '<input type="hidden" name="referer" value="' | cut -d "\"" -f6)
	hash=$(cat temp_page | grep '<input type="hidden" name="hash" value="' | cut -d "\"" -f6)
	
	#Download de page WITH the post variables, and get the video url
	echo -e "\033[1;32mDescargando \033[0;34m $id \033[1;36m $fname : \033[1;0m"
	wget --post-data "op=$op&usr_login=$usr_login&id=$id&fname=$fname&referer=$referer&url=$url&hash=$hash" $url -O page
	
	furl=$(cat page | grep 'file: "' | cut -d "\"" -f2)
	
	echo $furl
	
	#Clean and download the video :D	
	rm page temp_page
	
	wget -c --user-agent="Mozilla/5.0 (Windows NT 5.2; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" --output-document=$fname $furl
}

function sc
{
	#Save the variables POST	
	wget $url -q -O temp_page
	
	op=$(cat temp_page | grep '<input type="hidden" name="op" value="' | cut -d "\"" -f6)
	usr_login=$(cat temp_page | grep '<input type="hidden" name="usr_login" value="' | cut -d "\"" -f6)
	id=$(cat temp_page | grep '<input type="hidden" name="id" value="' | cut -d "\"" -f6)
	fname=$(cat temp_page | grep '<input type="hidden" name="fname" value="' | cut -d "\"" -f6)
	referer=$(cat temp_page | grep '<input type="hidden" name="referer" value="' | cut -d "\"" -f6)
	hash=$(cat temp_page | grep '<input type="hidden" name="hash" value="' | cut -d "\"" -f6)
	
	sleep 12
	
	#Download de page WITH the post variables, and get the video url
	echo -e "\033[1;32mDescargando \033[0;34m $id \033[1;36m $fname : \033[1;0m"
	wget -q --post-data "op=$op&usr_login=$usr_login&id=$id&fname=$fname&referer=$referer&url=$url&method_free=$hash" $url -O page
	
	furl=$(cat page | grep 'file: "' | cut -d "\"" -f2)
	
	echo $furl
	
	#Clean and download the video :D	
	rm page temp_page
	
	wget -c --output-document=$fname $furl
}

function pv   #powvideo
{
wget $url -q -O temp_page
	
	op=$(cat temp_page | grep '<input type="hidden" name="op" value="' | cut -d "\"" -f6)
	id=$(cat temp_page | grep '<input type="hidden" name="id" value="' | cut -d "\"" -f6)
	fname=$(cat temp_page | grep '<input type="hidden" name="fname" value="' | cut -d "\"" -f6)
	hash=$(cat temp_page | grep '<input type="hidden" name="hash" value="' | cut -d "\"" -f6)
	
	sleep 6
	
	#Download de page WITH the post variables, and get the video url

	echo $fname
		 
	curl -s $url -H 'Pragma: no-cache' -H 'Origin: http://powvideo.net' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: es-ES,es;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.132 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Referer: http://powvideo.net/97mgupu2eyv6' -H 'Cookie: lang=4; file_id=602446; aff=2671; ref_url=http%3A%2F%2Fseries.mu%2Fserie%2Fgreys-anatomy%2F' -H 'Connection: keep-alive' --data 'op=download1&usr_login=&id='$id'&fname='$fname'&referer='$url'&hash='$hash'&imhuman=Continuar+al+video' --compressed > page
	
	furl=$(cat page | egrep -o '\|'$id'\|[^\|]+\|' | cut -d "|" -f3)
	furl2=$(cat page | egrep -o '\|jpg\|[^\|]+\|' | cut -d "|" -f3)

	#Clean and download the video :D
	echo -e "\033[1;32mDescargando \033[0;34m $id \033[1;36m $fname : \033[1;0m"
	ffmpeg -y -i http://94.176.148.38:8777/$furl/$furl2.m3u8 -c copy "$fname"
	
	rm page temp_page
}

function fh		
{
	#Save the variables POST
	wget -q $url -q -O temp_page
	
	op=$(cat temp_page | grep '<input type="hidden" name="op" value="d' | cut -d "\"" -f6)
	usr_login=$(cat temp_page | grep '<input type="hidden" name="usr_login" value="' | cut -d "\"" -f6)
	id=$(cat temp_page | grep '<input type="hidden" name="id" value="' | cut -d "\"" -f6)
	fname=$(cat temp_page | grep '<input type="hidden" name="fname" value="' | cut -d "\"" -f6)
	referer=$(cat temp_page | grep '<input type="hidden" name="referer" value="' | cut -d "\"" -f6)
	method_free=$(cat temp_page | grep '<input id="plans_free_button_text" type="submit" class="btn btn-success btn-lg" name="method_free" value="' | cut -d "\"" -f10)
	
	echo -e "\033[1;32mDescargando \033[0;34m $id \033[1;36m $fname : \033[1;0m"
	#Download de page WITH the post variables, and get the video url

	wget -q --post-data "op=$op&usr_login=$usr_login&id=$id&fname=$fname&referer=$referer&url=$url&method_free=$method_free" $url -O page
	
	furl=$(cat page | egrep 'file: "http://[^"]+",' -m1 | cut -d "\"" -f2)

	#Clean and download the video :D
	rm page temp_page 
	
	curl -L -C - -# $furl > "$fname"

}

for url in $@ 
do
	server=$(echo $url | egrep '(allmyvideos|vidspot|streamcloud|played|powvideo|filehoot)' -o)
	case $server in
		"allmyvideos" ) amv $url ;;
		"vidspot" ) amv $url ;;
		"streamcloud" ) sc $url ;;
		"played" ) pt $url ;;
		"powvideo" ) pv $url ;;
		"filehoot" ) fh $url ;;
	esac
done
