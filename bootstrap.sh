# Set our database's root password to "rootpass"
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password rootpass'

# Let package manager apt-get update itself with newest list of packages (but only once)
if [ ! -f /var/log/apt-update ];
then
	touch /var/log/apt-update
	sudo apt-get update
fi

# These packages need to be installed for our server to execute our app
sudo apt-get -y install curl mysql-server-5.5 php5-mysql apache2 php5 php5-curl php5-mcrypt

# Composer will be the package manager for our 3rd party PHP libraries
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Create a new database (if it does not yet exist)
echo "CREATE DATABASE IF NOT EXISTS quizduell" | mysql -uroot -prootpass

# Add another user named "vagrant" with password "vagrant" that can connect from outside (i.e. from the VM-Host)
echo "CREATE USER 'vagrant'@'10.0.2.2' IDENTIFIED BY 'vagrant'" | mysql -uroot -prootpass
echo "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'10.0.2.2' WITH GRANT OPTION" | mysql -uroot -prootpass
echo "FLUSH PRIVILEGES" | mysql -uroot -prootpass

# Import the SQL dump located in /_vagrant/quizduell.sql into the new database (but only once)
if [ ! -f /var/log/database-import ];
then
	touch /var/log/database-import
	mysql -uroot -prootpass quizduell < /vagrant/_vagrant/quizduell.sql
fi

# Reconfigure MySQL to allow connection from outside the machine itself (i.e. from the VM-Host)
sed -i '/bind-address.*127.0.0.1/c bind-address = 0.0.0.0' /etc/mysql/my.cnf

# Tell MySQL to log queries, errors and slow queries and to put them into /public/logs
sed -i '/#general_log_file.*\/var\/log\/mysql\/mysql\.log/c general_log_file = /var/www/_logs/mysql-queries.log' /etc/mysql/my.cnf
sed -i '/#general_log.*1/c general_log = 1' /etc/mysql/my.cnf
sed -i '/log_error.*\/var\/log\/mysql\/error\.log/c log_error = /var/www/_logs/mysql-error.log' /etc/mysql/my.cnf
sed -i '/#log_slow_queries.*\/var\/log\/mysql\/mysql-slow\.log/c log_slow_queries = /var/www/_logs/mysql-slow.log' /etc/mysql/my.cnf
sed -i '/#long_query_time = 2/c long_query_time = 1' /etc/mysql/my.cnf

# Restart MySQL for the changes to take effect
service mysql restart

# Activate Apache2's mod_rewrite and mod_headers (just in case)
a2enmod rewrite
a2enmod proxy
a2enmod proxy_http
a2enmod headers

# Tell PHP to display error messages
sed -i '/display_errors = Off/c display_errors = On' /etc/php5/apache2/php.ini

# Increase maximum run time
sed -i '/max_execution_time = 30/c max_execution_time = 600' /etc/php5/apache2/php.ini
sed -i '/max_input_time = 60/c max_input_time = 600' /etc/php5/apache2/php.ini

# Increase memory limit
sed -i '/memory_limit = 128M/c memory_limit = 256M' /etc/php5/apache2/php.ini

# Tell Apache2 to allow all types of .htaccess directives
sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

# Tell Apache2 to put its error.log into /public/logs
sed -i '/ErrorLog ${APACHE_LOG_DIR}\/error.log/c ErrorLog /var/www/_logs/error.log' /etc/apache2/apache2.conf

# Restart Apache2 for the changes to take effect
service apache2 restart
