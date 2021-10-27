#! /bin/bash

# upload file if filename  doesnt exists

if [ -f filename ]; then
	echo "filename file already exists"
else 
	curl -q https://stevessmarthomeguide.com/internal-external-ip-addresses/ --output filename
fi

# use grep for get internal and external IP addresses from filename

if [ -f all_ip_addresses.txt ]; then
	echo "all_ip_addresses.txt file already exists"
else

# use grep for get internal and external IP addresses from filename 

cat /home/homework/filename | grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" >> all_ip_addresses.txt

fi

if [ -f internal.txt ]; then
        echo "internal.txt file already exists"
else

cat all_ip_addresses.txt | grep -o "192.168.[0-9]\{1,3\}\.[0-9]\{1,3\}" >> internal.txt
cat all_ip_addresses.txt | grep -o "10.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" >> internal.txt
cat all_ip_addresses.txt | grep -o "172.16.[0-9]\{1,3\}\.[0-9]\{1,3\}" >> internal.txt

fi



declare -a ip_lists # create a new array  for check Ip address validation
IFS=$'\n'


check_ip_validation()   #create function, which validate ip addresses from file
{

declare -a ip_lists # create a new array  for check Ip address validation

for line in $( cat $1 ); do
        ip_lists+=($line)
done


for i in ${ip_lists[@]}; do
#echo $i

IFS='.'    # change IFS value to '.' to get Ip address octets 
count=0
for j in $i; do
	if [ $j -gt 255 ]; then
		echo "$i IP Address is invalid" 
fi
done
done

}

# function parameter is filename

check_ip_validation all_ip_addresses.txt
#check_ip_validation internal.txt





