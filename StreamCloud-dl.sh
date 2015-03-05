#!/bin/bash

#		Download videos from streamcloud.eu
#		$1 = Video URL
#		By Jose Linares (http://jose-linares.com)
#		Licence: Creative commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) ( http://creativecommons.org/licenses/by-sa/3.0/deed.en)


for url in $@ 
do
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

	wget --post-data "op=$op&usr_login=$usr_login&id=$id&fname=$fname&referer=$referer&url=$url&method_free=$hash" $url -O page
	
	furl=$(cat page | grep 'file: "' | cut -d "\"" -f2)
	
	echo $furl
	
	#Clean and download the video :D
	
	rm page temp_page
	
	wget -c --output-document=$fname $furl
	
	
done
