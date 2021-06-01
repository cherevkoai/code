#https://serveradmin.ru/ustanovka-i-nastroyka-zabbix-4-0/

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
#mcedit /etc/php-fpm.d/www.conf
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
#echo "#MariaDB 10.3 CentOS repository list - created 2018-10-04 12:10 UTC" >> /etc/yum.repos.d/mariadb.repo
#echo "#http://downloads.mariadb.org/mariadb/repositories/" >> /etc/yum.repos.d/mariadb.repo
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

#echo "[client]" >> /etc/my.cnf.d/server.cnf
#echo "port		= 3306" >> /etc/my.cnf.d/server.cnf
#echo "socket		= /var/lib/mysql/mysql.sock" >> /etc/my.cnf.d/server.cnf
#echo "default-character-set=utf8" >> /etc/my.cnf.d/server.cnf

#echo "[mysqld]" >> /etc/my.cnf.d/server.cnf
#echo "character_set_server=utf8" >> /etc/my.cnf.d/server.cnf
#echo "collation-server=utf8_bin" >> /etc/my.cnf.d/server.cnf
#echo "init_connect=\"SET NAMES utf8 collate utf8_bin"\" >> /etc/my.cnf.d/server.cnf
#echo "port = 3306 socket = /var/lib/mysql/mysql.sock" >> /etc/my.cnf.d/server.cnf
# внимание на параметр! установить примерно в 2 раза меньше объема оперативной памяти сервера:
#echo "innodb_file_per_table=1 innodb_buffer_pool_size = 768M" >> /etc/my.cnf.d/server.cnf
# увеличивать на 1 каждый GB:
#echo "innodb_buffer_pool_instances=1" >> /etc/my.cnf.d/server.cnf
#######echo "innodb_buffer_pool_size" >> /etc/my.cnf.d/server.cnf с этой строкой ошибка MariaDB
#echo "innodb_flush_log_at_trx_commit = 0" >> /etc/my.cnf.d/server.cnf
#echo "innodb_log_file_size = 512M" >> /etc/my.cnf.d/server.cnf
#echo "innodb_log_files_in_group = 3" >> /etc/my.cnf.d/server.cnf
#echo "innodb-strict-mode = OFF" >> /etc/my.cnf.d/server.cnf
#echo "[server]" >> /etc/my.cnf.d/server.cnf
#echo "[galera]" >> /etc/my.cnf.d/server.cnf
#echo "[embedded]" >> /etc/my.cnf.d/server.cnf
#echo "[mariadb]" >> /etc/my.cnf.d/server.cnf
#echo "[mariadb-10.3]" >> /etc/my.cnf.d/server.cnf

#Установка сервера Zabbix 4.0 в CentOS

# rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
# yum install zabbix-server-mysql zabbix-web-mysql

#В зависимостях пакетов будет httpd, который нам не нужен, так как у нас будет nginx и php7.1, но я не разбирался, как поставить без него. После установки пакетов, создадим базу данных, пользователя zabbix и заполним базу.
# mysql -uroot -p
#в СУБД создаем базу и структуру:
#> create database zabbix character set utf8 collate utf8_bin;
#> grant all privileges on zabbix.* to zabbix@localhost identified by 'zabpassword';
#exit

#Теперь редактируем файл конфигурации сервера заббикс. Прописываем данные для подключения к БД, отключаем ipv6 и увеличиваем стандартный timeout.
# mcedit /etc/zabbix/zabbix_server.conf
#Изменяем указанные строки, остальные не трогаем:
#DBHost=localhost
#DBName=zabbix
#DBUser=zabbix
#DBPassword=zabpassword
#ListenIP=0.0.0.0
#Timeout=10

#Запускаем zabbix и добавляем в автозагрузку.
# systemctl start zabbix-server
# systemctl enable zabbix-server

#Проверяем лог файл на наличие ошибок.
# cat /var/log/zabbix/zabbix_server.log

#Настройка SELinux с zabbix

# yum install policycoreutils-python
# cd ~
# curl https://support.zabbix.com/secure/attachment/53320/zabbix_server_add.te > zabbix_server_add.te
# checkmodule -M -m -o zabbix_server_add.mod zabbix_server_add.te
# semodule_package -m zabbix_server_add.mod -o zabbix_server_add.pp
# semodule -i zabbix_server_add.pp

#Теперь нам надо перезапустить zabbix-server.
#systemctl restart zabbix-server

#Если у вас это не получится сделать через systemctl, значит служба зависла. Завершаем ее принудительно и запускаем снова.
# kill -9 `pidof zabbix_server`
# systemctl start zabbix-server

#С серверной частью закончили. Нам нужно сделать конфиг nginx для работы web интерфейса zabbix на сервере с Centos 7. Если у вас nginx работает на том же сервере, где сам zabbix, и других виртуальных хостов нет и не будет, то правьте сразу дефолтный - /etc/nginx/conf.d/default.conf. Приводим его к следующему виду:
# mcedit /etc/nginx/conf.d/default.conf
#server {
#    listen       80;
#    server_name  localhost;
#    root /usr/share/zabbix;

#    location / {
#	index index.php index.html index.htm;
#    }

#    location ~ \.php$ {
#	fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
#	fastcgi_index index.php;
#	fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
#	include fastcgi_params;
#	fastcgi_param PHP_VALUE "
#	max_execution_time = 300
#	memory_limit = 128M
#	post_max_size = 16M
#	upload_max_filesize = 2M
#	max_input_time = 300
#	date.timezone = Europe/Moscow
#	always_populate_raw_post_data = -1
#	";
#	fastcgi_buffers 8 256k;
#	fastcgi_buffer_size 128k;
#	fastcgi_intercept_errors on;
#	fastcgi_busy_buffers_size 256k;
#	fastcgi_temp_file_write_size 256k;
#        }
#}

#Маленький, но важный нюанс. Нам надо изменить права доступа на некоторые папки. Назначить владельца nginx.
# chown -R nginx:nginx /var/lib/php/session
# chown -R nginx:nginx /etc/zabbix/web

#Этот шаг нужно будет проделывать после каждого обновления php или zabbix. Связано с тем, что по-умолчанию zabbix идет в комплекте с apache и рассчитан на работу с ним. Поэтому после установки или обновления, он делает его владельцем директории /etc/zabbix/web.

#Даем разрешения SELinux для работы заббикса с web сервером и базой данных.
# setsebool -P httpd_can_connect_zabbix on
# setsebool -P httpd_can_network_connect_db on


#В браузере вводим сдрес сервера
