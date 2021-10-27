#! /bin/bash


echo "Hello World" > index.html
sudo apt update -y
sudo apt install  nginx -y
echo "server {
    listen 80 default_server;
    root /tmp/acatest/;
    index index.html;
    location / {
    }
}" > hello

sudo cp hello /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

sudo systemctl restart nginx.service
