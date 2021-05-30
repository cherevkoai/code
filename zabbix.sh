#Download Zabbix 4.2 

# systemctl stop firewalld
# systemctl disable firewalld
#Подключаем репозиторий nginx и устанавливаем его:
# rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
# yum install nginx
# systemctl start nginx
# systemctl enable nginx
#Дальше устанавливаем php-fpm. Для этого подключаем репозиторий remi и epel-release.
# yum install epel-release
# rpm -Uhv http://rpms.remirepo.net/enterprise/remi-release-7.rpm
#Активируем репу remi-php71, для этого выполняем команды:
# yum install yum-utils
# yum-config-manager --enable remi-php71
#Устанавливаем php 7.1 и модули к нему.
# yum install php71 php-fpm php-cli php-mysql php-gd php-ldap php-odbc php-pdo php-pecl-memcache php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-bcmath
#Запускаем php-fpm и добавляем в автозагрузку.
# systemctl start php-fpm
# systemctl enable php-fpm
#Проверяем, запустился ли он.
# netstat -tulpn | grep php-fpm
#tcp        0      0 127.0.0.1:9000          0.0.0.0:*               LISTEN      13261/php-fpm: mast
#Все в порядке, запустился на порту 9000. Запустим его через unix сокет. Для этого открываем конфиг /etc/php-fpm.d/www.conf и комментируем строку:
## mcedit /etc/php-fpm.d/www.conf
#;listen = 127.0.0.1:9000
#echo "listen = /var/run/php-fpm/php-fpm.sock" >> /etc/php-fpm.d/www.conf
#echo "listen.mode = 0660" >> /etc/php-fpm.d/www.conf
#echo "listen.owner = nginx" >> /etc/php-fpm.d/www.conf
#echo "listen.group = nginx" >> /etc/php-fpm.d/www.conf
#Заодно измените пользователя, от которого будет работать php-fpm. Вместо apache укажите nginx, отредактировав соответствующие параметры.
#user = nginx изменить apache на nginx
#group = nginx изменить apache на nginx
#Перезапускаем php-fpm.
# systemctl restart php-fpm
#Проверяем, стартовал ли указанный сокет.
#ll /var/run/php-fpm/php-fpm.sock 
# mcedit /etc/yum.repos.d/mariadb.repo
#записываем в файл:
#echo "echo "MariaDB 10.3 CentOS repository list - created 2018-10-04 12:10 UTC" >>
#echo "http://downloads.mariadb.org/mariadb/repositories/" >> /etc/yum.repos.d/mariadb.repo
#echo "[mariadb]" >> /etc/yum.repos.d/mariadb.repo
#echo "name = MariaDB" >> /etc/yum.repos.d/mariadb.repo
#echo "baseurl = http://yum.mariadb.org/10.3/centos7-amd64" >> /etc/yum.repos.d/mariadb.repo
#echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/mariadb.repo
#echo "gpgcheck=1" >> /etc/yum.repos.d/mariadb.repo
#Устанавливаем последнюю версию mariadb на centos.
# yum install MariaDB-server MariaDB-client
#Запускаем mariadb и добавляем в автозагрузку.
# systemctl start mariadb
# systemctl enable mariadb
#Запускаем скрипт начальной конфигурации mysql и задаем пароль для root. Все остальное можно оставить по-умолчанию.
# /usr/bin/mysql_secure_installation
#Внесем некоторые изменения в стандартный конфиг mariadb, чтобы потом не заниматься очисткой и оптимизацией базы для zabbix. Для этого открываем конфиг mysql /etc/my.cnf.d/server.cnf и приводим его к следующему виду.
# mcedit /etc/my.cnf.d/server.cnf
#[client]
#port		= 3306
#socket		= /var/lib/mysql/mysql.sock
#default-character-set=utf8

#[mysqld]
#character_set_server=utf8
#collation-server=utf8_bin 
#init_connect="SET NAMES utf8 collate utf8_bin"
#port = 3306
#socket = /var/lib/mysql/mysql.sock
#innodb_file_per_table=1 innodb_buffer_pool_size = 768M # внимание на параметр! установить примерно в 2 раза меньше объема оперативной памяти сервера
#innodb_buffer_pool_instances=1 # увеличивать на 1 каждый GB
#innodb_buffer_pool_size
#innodb_flush_log_at_trx_commit = 0
#innodb_log_file_size = 512M
#innodb_log_files_in_group = 3
#innodb-strict-mode = OFF
#[server]
#[galera]
#[embedded]
#[mariadb]
#[mariadb-10.3]
