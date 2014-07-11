
sudo apt-get install -y git
sudo apt-get install -y gcc g++
sudo apt-get install -y python python-dev python-software-properties
sudo add-apt-repository -y ppa:ubuntugis/ppa
sudo apt-get update -qq

sudo apt-get install -y gdal-bin libgdal-dev python-gdal
sudo apt-get install -y pip
sudo pip install virtualenv
virtualenv TESTING
source TESTING/bin/activate

sudo apt-get install -y apache2-mpm-worker apache2-dev
wget http://modwsgi.googlecode.com/files/mod_wsgi-3.4.tar.gz
tar xvfz mod_wsgi-3.4.tar.gz
cd mod_wsgi-3.4
./configure
sudo make
sudo make install
echo "LoadModule wsgi_module /usr/lib/apache2/modules/mod_wsgi.so" > /etc/apache2/mods-available/wsgi.load
sudo a2enmod wsgi
sudo a2dissite default

cd /srv/
sudo git clone https://github.com/fgassert/watershed_app.git
sudo pip install -r watershed_app/requirements-dev.txt
sudo pip install -r watershed_app/requirements.txt

sudo useradd --system --no-create-home --home-dir /srv/watershed_app --user-group DJANGO_APP
sudo chsh -s /bin/bash DJANGO_APP

wget https://raw.github.com/fgassert/watershed_app/master/apache_conf
sudo mv apache_conf /etc/apache2/sites-available/md.cc

sudo a2ensite md.cc

chown -R DJANGO_APP:DJANGO_APP /srv/watershed_app/

service apache2 restart

