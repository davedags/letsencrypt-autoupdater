#letsencrypt-autoupdater

## Prerequisites

1. Have `letsencrypt` installed 
 * see the [letsencrypt website](https://letsencrypt.org/) 
 * and [documentation](https://community.letsencrypt.org/c/docs/) for more info about usage of letsencrypt, or

2. Have a directory `/etc/letsencrypt` and [create your ".ini" files](http://letsencrypt.readthedocs.org/en/latest/using.html#configuration-file) with all necessary settings to have your certificates processes in a unattended fashion (see below for a sample), not requiring any manual intervention.

 * See sample.ini 

3. Create environment file for necessary config values (i.e. base directory)

 * Copy .env.example to .env and adjust accordingly
 * If no .env file created, script will assume the current working directory contains all of the letsencrypt install files

4. Setup updater.sh to run automatically via cron on whatever schedule you want to auto update certificates

## Important

1. This auto script assumes Apache HTTP and will perform a systemctl reload httpd at the end.  You may need to modify the script if you are running in an environment that does not contain systemd or you run nginx or something different

2. With this configuration, Letsencrypt puts the certificates in the following directory:  /etc/letsencrypt/live/mydomain.com-0001 (or equivalent).   You should create a permanent symlink such as:

#ln -s /etc/letsencrypt/live/mydomain.com-0001 /etc/letsencrypt/live/mydomain.com
#ln -s /etc/letsencrypt/archive/mydomain.com-0001 /etc/letsencrypt/archive/mydomain.com

3. Update your Apache config where you specify the SSL Certs


    SSLCertificateFile /etc/letsencrypt/live/mydomain.com/cert.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/mydomain.com/privkey.pem
    SSLCertificateChainFile /etc/letsencrypt/live/mydomain.com/chain.pem

