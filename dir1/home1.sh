#! /bin/bash

file="/etc/apt/sources.list"

function ConvertTo {

mkdir -p /home/$4
IFS=$'\n'
count=1
n=$( cat $file | wc -l )

for var1 in $( cat $1 )
do
	echo "$var1" | grep "$2://*"
	if [ $? -eq 0 ]; then
		count=$(($count+1))
	if [ -f /home/$4/url$count.txt ]; then
		echo "url$count.txt file already exists"
	else 
		echo $var1 | sed 's/$2/$3/g' >> /home/$4/url$count.txt
	fi
	fi
	done
}


function create_and_upload_bucket {


        
                aws s3api create-bucket --bucket $1 --region us-east-1
                if [ $? -eq 0 ]; then
                        echo "Bucketc $1 successfuly created"
			aws s3 cp /home/$2/ s3://$1 --recursive
                else
                        echo "Error!"
        fi

}

ConvertTo $file http https upload1
ConvertTo $file main universe upload2
create_and_upload_bucket grish.bucket11 upload1
create_and_upload_bucket grish.bucket13 upload2

