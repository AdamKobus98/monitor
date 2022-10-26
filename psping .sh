#!/bin/bash

#alias psping='psping.sh'
EXE_NAME=${@: -1}
username=""
time=1

display(){

echo $EXE_NAME": "$(ps -fu $username | grep "${EXE_NAME}" |wc -l)" instance(s)"
}
waiting(){
sleep $time
}

display_help() {
    echo "psping [option...] exe-name" >&2
    echo
    echo "   -c, --count     limit amount of pings"
    echo "   -t, --time      define alternative timeout in seconds, e.g. -t 5. Default is 1 sec"
    echo "   -u, --username  define user to check process for. Default is ANY user."
    echo	
    # echo some stuff here for the -a or --add-options 
    exit 1
}



perform_ping(){
a=1
if [ $count > 0 ];then 
echo "Pinging" $EXE_NAME "for user" $username
	while [ $a -le $count ] 
	do
		display
		((a++))
		waiting
	done
else
	while true;do
		display
 		waiting
	done
fi
}


while getopts c:t:u:h: flag
do
    case "${flag}" in
        c) count=${OPTARG};;
        t) time=${OPTARG};;
        u) username=${OPTARG};;
	h) display_help 
	exit;;
          
    esac
   
done
perform_ping


