#!/bin/bash

sudo su

apt-get install -y git
apt-get install -y gcc 
apt-get install -y g++
apt-get install -y python 
apt-get install python-dev python-software-properties
add-apt-repository -y ppa:ubuntugis/ppa
apt-get update -qq
apt-get install -y p7zip
apt-get install -y gdal-bin libgdal-dev python-gdal
apt-get install -y python-pip
pip install virtualenv

apt-get install -y apache2-mpm-worker apache2-dev apache2-utils
apt-get install -y libapache2-mod-wsgi
a2enmod wsgi
a2enmod headers
a2dissite default

cd /srv/
virtualenv TESTING
source TESTING/bin/activate

export C_INCLUDE_PATH=/usr/include/gdal
export CPLUS_INCLUDE_PATH=/usr/include/gdal
git clone https://github.com/fgassert/watershed_app.git
pip install -r watershed_app/requirements-dev.txt
pip install -r watershed_app/requirements.txt


useradd --system --no-create-home --home-dir /srv/watershed_app --user-group DJANGO_APP
chsh -s /bin/bash DJANGO_APP

mkdir watershed_app/logs
wget http://md.cc.s3.amazonaws.com/tmp/assets.7z
p7zip -d assets.7z
mv assets /srv/watershed_app/

mv watershed_app/apache_conf /etc/apache2/sites-available/md.cc.conf

a2ensite md.cc

chown -R DJANGO_APP:DJANGO_APP /srv/watershed_app/

service apache2 restart

