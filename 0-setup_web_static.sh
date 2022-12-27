#!/usr/bin/env bash

#checks if Nginx is already installed
if ![-x "$(command -v nginx)"];
then
	# install Nginx
	sudo apt-get update
	sudo apt-get install nginx -y

fi

# create a directory /data/ if 
# it does not already exist
if [ ! -d "/data/" ];
then
	sudo mkdir /data/
fi

# create a directory /data/web_static/ if 
# it does not already exist
if [ ! -d "/data/web_static/" ];
then
        sudo mkdir -p /data/web_static/
fi

# create a directory /data/web_static/releases/
# if it does not already exist
if [ ! -d "/data/web_static/releases/" ];
then
	sudo mkdir -p /data/web_static/releases/
fi

# create a directory /data/web_static/shared/
# if it does not already exist

if [ ! -d "/data/web_static/shared/" ];
then
	sudo mkdir -p /data/web_static/shared/
fi

# create a directoy /data/web_static/releases/test/
# if it does not already exist
if [ ! -d "/data/web_static/releases/test/" ];
then
	sudo mkdir -p /data/web_static/releases/test/
fi

# create a fake index.html file with simple content
echo "Holberton School" > /data/web_static/releases/test/index.html

# create a symbolic link /data/web_static/current
ln -sf /data/web_static/releases/test/ /data/web_static/current

#give ownership of /data/ folder to ubuntu user
# and group
chown -R ubuntu /data/
chgrp -R ubuntu /data/

# Update the Nginx configuration to serve the content 
# of /data/web_static/current/ to hbnb_static

printf %s"server{
listen 80 default_server;
listen [::]:80 default_server;
add_header X-Served-By $HOSTNAME;
root /var/www/html;
index index.html index.htm;

location /hbnb_static{
    alias /data/web_static/current;
    index index.html index.htm;
}
location /redirect_me{
return 301 http://cuberrule.com/;
}

error_page 404 /404.html;
location = /404.html {
root /var/www/html;
internal;
}
}" > /etc/nginx/sites-available/default
