#!/bin/sh

if [ -z $LETSENCRYPT_BASE_DIR ]; then

    if [ ! -f ./.env ]; then
	echo 'Error: .env file is required';
    fi

    source ./.env

    if [ -z $LETSENCRYPT_BASE_DIR ]; then
      LETSENCRYPT_BASE_DIR=$(pwd)
      echo 'Warning: LETSENCRYPT_BASE_DIR not defined, using current directory: ' $LETSENCRYPT_BASE_DIR
    fi
    cd ${LETSENCRYPT_BASE_DIR}
fi
CURRENT_MONTH=$(date +%m)

printf "stopping httpd\n";
systemctl stop httpd;
sleep 1;

printf "Updating Certificates ... \n\n"

./letsencrypt-auto -c /etc/letsencrypt/cli.ini certonly --standalone

printf "starting httpd\n";
systemctl start httpd;

