#!/usr/bin/env bash

apt-get -y update

# Install Ruby on Rails

# Install some Ruby dependencies
echo "Installing some Ruby dependencies"
apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Install Ruby (v2.2.2) from source
echo "Installing Ruby (v2.2.3)"
cd /tmp
wget http://ftp.ruby-lang.org/pub/ruby/2.3/ruby-2.2.3.tar.gz
tar -xzvf ruby-2.2.3.tar.gz
cd ruby-2.2.3/
./configure
make
make install
ruby -v

# Now we tell Rubygems not to install the documentation for each package locally and then install Bundler
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

# Install NodeJS
echo "Installing NodeJS"
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs

# Install Rails (v4.2.1)
echo "Installing Rails (v4.2.1)"
gem install rails -v 4.2.1
rails -v

# Install PostgreSQL
echo "Installing PostgreSQL"
# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.3

apt-get -y update
apt-get -y install postgresql-common
apt-get -y install "postgresql-$PG_VERSION" libpq-dev

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
sudo sed -i "$ a\host    all             all             all                     trust" "$PG_HBA"

# Restart so that all new config is loaded:
service postgresql restart

# Create a PostgreSQL user for vagrant
sudo -u postgres createuser vagrant -s

# Install imageMagick as ImageProcesor of PaperClick GEM
# sudo apt-get --force-yes install imagemagick -y

# Install wkhtmltopdf for PDF Kit gem
# sudo -su root
# wget http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9-static-amd64.tar.bz2
# tar xvjf wkhtmltopdf-0.9.9-static-amd64.tar.bz2
# mv wkhtmltopdf-amd64 /usr/local/bin/wkhtmltopdf
# chmod +x /usr/local/bin/wkhtmltopdf
# exit
