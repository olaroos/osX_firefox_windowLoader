#!/bin/bash
number="`wc -l < $1`"
printf "tell application \"System Events\"\n\t" >> output
for (( i=1; i<=$number+1; ++i))
do 
	cut=$(cat $1 | grep -n "" | grep $i: | sed 's/'$i':\(.*\)/\1/')
	printf "if (name of processes) contains \"Firefox\" then\n\t\ttell application \"Firefox\" to activate\n\t\tkeystroke \"t\" using command down\n\tend if\n\tif (name of processes) contains \"Firefox\" then\n\t\tset the clipboard to \"$cut\"\n\tend if\n\tif (name of processes) contains \"Firefox\" then\n\t\ttell application \"Firefox\" to activate\n\t\tkeystroke \"v\" using command down\n\tend if\n\tif (name of processes) contains \"Firefox\" then\n\t\ttell application \"Firefox\" to activate\n\t\tkey code 36\n\tend if\n" >> output
done
printf "\nend tell" >> output
osascript output
rm output