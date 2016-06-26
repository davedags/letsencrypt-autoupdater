#!/bin/sh


LINK=$(readlink -f "$0");

if [ -z $LINK ]; then
    DIR=$PWD
else
    DIR=$(dirname $LINK);
fi

cd $DIR

if [ -z $LETSENCRYPT_BASE_DIR ]; then

    if [ ! -f ./.env ]; then
	echo 'Error: .env file is required';
    fi

    source ./.env

    if [ -z $LETSENCRYPT_BASE_DIR ]; then
      LETSENCRYPT_BASE_DIR=$PWD
      echo 'Warning: LETSENCRYPT_BASE_DIR not defined, using current directory: ' $LETSENCRYPT_BASE_DIR
    fi

fi

CURRENT_MONTH=$(date +%m)
cd ${LETSENCRYPT_BASE_DIR}

printf "stopping httpd\n";
systemctl stop httpd;
sleep 1;

printf "Updating Certificates ... \n\n"

./letsencrypt-auto -c /etc/letsencrypt/cli.ini certonly --standalone

printf "starting httpd\n";
systemctl start httpd;

