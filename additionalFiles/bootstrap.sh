#!/usr/bin/env bash

apt-get update
apt-get install -y apache2 libapache2-mod-php5 php5 php5-mysql php5-curl
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 1234'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 1234'
sudo apt-get -y install mysql-server

#install MySQL seperately (give password!):
#apt-get install mysql-server
#user: root pw: 1234

#stuff needed for hotCRP
apt-get install -y php5-common php5-gd #zip poppler-utils #sendmail
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

#clone git into the repo
apt-get install -y git
git config --global user.email "ivoschueepp@gmail.com"
git config --global user.name "iivooo"
#mkdir /vagrant/html/
#git clone https://github.com/iivooo/hotcrp.git:/vagrant/html/

#if you first set hotcrp/conf/options.php the right DB settings installation is
#straight forward

# install phpmyadmin aditional - set alias in apache2.conf
#
#hotcrp login: ivoschueepp@gmail.com pw: 1234

service apache2 start
