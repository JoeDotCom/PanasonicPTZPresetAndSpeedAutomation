echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~ PanasonicPTZPresetAndSpeedAutomation"
echo "~ By Joe and Anupam :)   "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

preset=1
alt=1
speed=500
speedmod=500
increment=50
oldspeed=500
oldpreset=0


while :
do
    # TASK 1
   # date
  
#sleep .2



read -t 1 -n 1 key


if [[ $key = 1 ]]; then
osascript -e 'tell application "ATEM Software Control" to activate'
osascript -e 'tell application "System Events" to keystroke 1 using control down'
osascript -e 'tell application "Terminal" to activate'
key=clear
fi


if [[ $key = 2 ]]; then
osascript -e 'tell application "ATEM Software Control" to activate'
osascript -e 'tell application "System Events" to keystroke 2 using control down'
osascript -e 'tell application "Terminal" to activate'
key=clear
fi


#######################
# speed selection
######################
# if [[ $key = 1 ]]; then speed=100; speedmod=100; key=clear; fi
# if [[ $key = 2 ]]; then speed=200; speedmod=200; key=clear; fi
if [[ $key = 3 ]]; then speed=300; speedmod=300; key=clear; fi
if [[ $key = 4 ]]; then speed=400; speedmod=400; key=clear; fi
if [[ $key = 5 ]]; then speed=500; speedmod=500; key=clear; fi
if [[ $key = 6 ]]; then speed=600; speedmod=600; key=clear; fi
if [[ $key = 7 ]]; then speed=700; speedmod=700; key=clear; fi
if [[ $key = 8 ]]; then speed=800; speedmod=800; key=clear; fi
if [[ $key = 9 ]]; then speed=900; speedmod=900; key=clear; fi
if [[ $key = 0 ]]; then speed=999; speedmod=999; key=clear; fi


#######################
# preset selection
######################
if [[ $key = q ]]; then preset=27; speedmod=$(($speed - $increment * 4)); key=clear; fi
if [[ $key = w ]]; then preset=27; speedmod=$(($speed - $increment * 3)); key=clear; fi
if [[ $key = e ]]; then preset=27; speedmod=$(($speed - $increment * 2)); key=clear; fi
if [[ $key = r ]]; then preset=27; speedmod=$(($speed - $increment * 1)); key=clear; fi
if [[ $key = t ]]; then preset=27; speedmod=$(($speed                 )); key=clear; fi
if [[ $key = y ]]; then preset=27; speedmod=$(($speed + $increment * 1)); key=clear; fi
if [[ $key = u ]]; then preset=27; speedmod=$(($speed + $increment * 2)); key=clear; fi
if [[ $key = i ]]; then preset=27; speedmod=$(($speed + $increment * 3)); key=clear; fi
if [[ $key = o ]]; then preset=27; speedmod=$(($speed + $increment * 4)); key=clear; fi

if [[ $key = a ]]; then preset=20; speedmod=$(($speed - $increment * 4)); key=clear; fi
if [[ $key = s ]]; then preset=20; speedmod=$(($speed - $increment * 3)); key=clear; fi
if [[ $key = d ]]; then preset=20; speedmod=$(($speed - $increment * 2)); key=clear; fi
if [[ $key = f ]]; then preset=20; speedmod=$(($speed - $increment * 1)); key=clear; fi
if [[ $key = g ]]; then preset=20; speedmod=$(($speed                 )); key=clear; fi
if [[ $key = h ]]; then preset=20; speedmod=$(($speed + $increment * 1)); key=clear; fi
if [[ $key = j ]]; then preset=20; speedmod=$(($speed + $increment * 2)); key=clear; fi
if [[ $key = k ]]; then preset=20; speedmod=$(($speed + $increment * 3)); key=clear; fi
if [[ $key = l ]]; then preset=20; speedmod=$(($speed + $increment * 4)); key=clear; fi


if [[ $key = z ]]; then preset=23; speedmod=$(($speed - $increment * 4)); key=clear; fi
if [[ $key = x ]]; then preset=23; speedmod=$(($speed - $increment * 3)); key=clear; fi
if [[ $key = c ]]; then preset=23; speedmod=$(($speed - $increment * 2)); key=clear; fi
if [[ $key = v ]]; then preset=23; speedmod=$(($speed - $increment * 1)); key=clear; fi
if [[ $key = b ]]; then preset=23; speedmod=$(($speed                 )); key=clear; fi
if [[ $key = n ]]; then preset=23; speedmod=$(($speed + $increment * 1)); key=clear; fi
if [[ $key = m ]]; then preset=23; speedmod=$(($speed + $increment * 2)); key=clear; fi
if [[ $key = , ]]; then preset=23; speedmod=$(($speed + $increment * 3)); key=clear; fi
if [[ $key = . ]]; then preset=23; speedmod=$(($speed + $increment * 4)); key=clear; fi


echo heartbeat:: preset $preset speed $speed speedmod = $speedmod  oldspeed = $oldspeed key = $key



#######################
# check for new speed and fire off
######################	
if [[ $speedmod != $oldspeed ]]
	then 
		echo NEW speed: preset $preset speed $speed speedmod = $speedmod
		curl "http://192.168.0.11/cgi-bin/aw_ptz?cmd=%23UPVS$speedmod&res=1" \
		  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
		  -H 'Accept-Language: en-US,en;q=0.9' \
		  -H 'Authorization: Basic YWRtaW46MTIzNDU=' \
		  -H 'Connection: keep-alive' \
		  -H 'Cookie: Session=0' \
		  -H 'Referer: http://192.168.0.11/admin/setup_camera_preset_frame.html' \
		  -H 'Upgrade-Insecure-Requests: 1' \
		  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' \
		  --compressed \
		  --insecure    
		oldspeed=$speedmod
		triggerpreset=1
	fi
		
		
		
#######################
# check for new preset and fire off
######################	
if [[ $preset != $oldpreset ]] || [[ $triggerpreset = 1 ]]
	then 
		#######################
		# preset alternator
		######################
		if [ $alt = 1 ]
		then
		  preset=$((preset + 1))
		  alt=0
		  echo alt: $alt
		else
		  alt=1
		  		  echo alt: $alt

		fi
		echo NEW PRESET: preset $preset alt: $alt speed $speed speedmod = $speedmod
		 curl "http://192.168.0.11/cgi-bin/aw_ptz?cmd=%23UPVS$speedmod&res=1" \
		 -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
		  -H 'Accept-Language: en-US,en;q=0.9' \
		  -H 'Authorization: Basic YWRtaW46MTIzNDU=' \
		  -H 'Connection: keep-alive' \
		  -H 'Cookie: Session=0' \
		  -H 'Referer: http://192.168.0.11/admin/setup_camera_preset_frame.html' \
		  -H 'Upgrade-Insecure-Requests: 1' \
		  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' \
		  --compressed \
		  --insecure    
#sleep .2
		  curl "http://192.168.0.11/cgi-bin/aw_ptz?cmd=%23R$preset&res=1" \
		  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
		  -H 'Accept-Language: en-US,en;q=0.9' \
		  -H 'Authorization: Basic YWRtaW46MTIzNDU=' \
		  -H 'Connection: keep-alive' \
		  -H 'Cookie: Session=0' \
		  -H 'Referer: http://192.168.0.11/admin/setup_camera_preset_frame.html' \
		  -H 'Upgrade-Insecure-Requests: 1' \
		  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' \
		  --compressed \
		  --insecure    
				
		
		oldpreset=$preset
		triggerpreset=0

		if [[ $preset = 27 ]] || [[ $preset = 28 ]]
		then 
		say "Left" -r 400 
		fi

		if [[ $preset = 20 ]] || [[ $preset = 21 ]]
		then 
		say "Mid" -r 400 
		fi

		if [[ $preset = 23 ]] || [[ $preset = 24 ]]
		then 
		say "Right" -r 400 
		fi				
		
#		if [[ $preset = 23 ]] || [[ $preset = 24 ]]
#		 THEN 
#		 say "Right" -r 400 
#		 fi
#		if [[ $preset = 27 ]] || [[ $preset = 28 ]] 
#		THEN  
#		say "left" -r 400
#		 fi
		
say $speedmod	 -r 400	
	fi
				






   
done #end keylistener







