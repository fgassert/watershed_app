
sudo apt-get install -y git
sudo apt-get install -y gcc g++
sudo apt-get install -y python python-dev python-software-properties
sudo add-apt-repository -y ppa:ubuntugis/ppa
sudo apt-get update -qq

sudo apt-get install -y gdal-bin libgdal-dev python-gdal
sudo apt-get install -y python-pip
sudo pip install virtualenv

sudo apt-get install -y apache2-mpm-worker apache2-dev
sudo apt-get install -y valibapache2-mod-wsgi
sudo apt-get install -y p7zip
sudo a2enmod wsgi
sudo a2dissite default

cd /srv/
sudo virtualenv TESTING
source TESTING/bin/activate

sudo git clone https://github.com/fgassert/watershed_app.git
sudo pip install -r watershed_app/requirements-dev.txt
sudo pip install -r watershed_app/requirements.txt


sudo useradd --system --no-create-home --home-dir /srv/watershed_app --user-group DJANGO_APP
sudo chsh -s /bin/bash DJANGO_APP

sudo mkdir watershed_app/logs
sudo wget http://md.cc.s3.amazonaws.com/tmp/assets.7z
sudo p7zip -d assets.7z
sudo mv assets /srv/watershed_app/

sudo mv watershed_app/apache_conf /etc/apache2/sites-available/md.cc

sudo a2ensite md.cc

sudo chown -R DJANGO_APP:DJANGO_APP /srv/watershed_app/

sudo service apache2 restart

