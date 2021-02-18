mkdir /etc/keys

openssl req -x509 -nodes -newkey rsa:2048 -days 365 -keyout /etc/keys/my_key.key -out \
/etc/keys/my_certificate.crt -subj /C=RU/ST=/L=KAZAN/O=School21/CN=unlix.ru

service nginx start
service php7.3-fpm start
service mysql start


chmod -R 755 /var/www/*

echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

bash