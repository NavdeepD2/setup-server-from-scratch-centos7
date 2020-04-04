#!/bin/bash
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
systemctl disable NetworkManager 
systemctl stop NetworkManager 
yum install -y wget screen atop iftop mlocate iotop htop vim telnet zip net-tools unzip  smartmontools bind-utils
yum -y update
# Download latest kernel
wget http://mirror.imt-systems.com/elrepo/archive/kernel/el7/x86_64/RPMS/kernel-lt-4.4.206-1.el7.elrepo.x86_64.rpm http://mirror.imt-systems.com/elrepo/archive/kernel/el7/x86_64/RPMS/kernel-lt-devel-4.4.206-1.el7.elrepo.x86_64.rpm http://mirror.imt-systems.com/elrepo/archive/kernel/el7/x86_64/RPMS/kernel-lt-headers-4.4.206-1.el7.elrepo.x86_64.rpm http://mirror.imt-systems.com/elrepo/archive/kernel/el7/x86_64/RPMS/kernel-lt-tools-4.4.206-1.el7.elrepo.x86_64.rpm http://mirror.imt-systems.com/elrepo/archive/kernel/el7/x86_64/RPMS/kernel-lt-tools-libs-4.4.206-1.el7.elrepo.x86_64.rpm http://mirror.imt-systems.com/elrepo/archive/kernel/el7/x86_64/RPMS/kernel-lt-tools-libs-devel-4.4.206-1.el7.elrepo.x86_64.rpm
# Download R1soft packages
wget http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/serverbackup-agent-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/serverbackup-async-agent-2-6-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/serverbackup-enterprise-agent-6.12.0.x86_64.rpm  http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/serverbackup-enterprise-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/serverbackup-setup-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/r1soft-getmodule-1.0.0-79.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/r1soft-cdp-agent-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/r1soft-cdp-async-agent-2-6-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/r1soft-cdp-enterprise-agent-6.12.0.x86_64.rpm http://r1soft.mirror.iweb.ca/repo.r1soft.com/yum/stable/x86_64/r1soft-setup-6.12.0.x86_64.rpm

yum install kernel-lt-4.4.206-1.el7.elrepo.x86_64.rpm -y;yum -y install kernel-lt-devel-4.4.206-1.el7.elrepo.x86_64.rpm ; yum -y install kernel-lt-headers-4.4.206-1.el7.elrepo.x86_64.rpm
grub2-mkconfig –o /boot/grub2/grub.cfg
grub2-set-default 0
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg
reboot
yum remove `rpm -qa|grep kernel|grep tools` -y
yum install -y kernel-lt-tools-4.4.206-1.el7.elrepo.x86_64.rpm kernel-lt-tools-libs-4.4.206-1.el7.elrepo.x86_64.rpm kernel-lt-tools-libs-devel-4.4.206-1.el7.elrepo.x86_64.rpm
yum install -y r1soft-getmodule-1.0.0-79.x86_64.rpm 
yum install -y serverbackup-async-agent-2-6-6.12.0.x86_64.rpm 
yum install -y serverbackup-setup-6.12.0.x86_64.rpm 
yum install -y serverbackup-agent-6.12.0.x86_64.rpm
yum install -y serverbackup-enterprise-agent-6.12.0.x86_64.rpm

# Edit parameters for all PHP versions' in configuration files
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/disable_functions =/disable_functions = show_source, system, shell_exec, passthru, popen, escapeshellcmd, myshellexec/g'
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/max_execution_time =.*/max_execution_time = 3600/g'
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/memory_limit =.*/memory_limit = 512M/g'
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/max_input_time =.*/max_input_time = 3600/g'
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/post_max_size =.*/post_max_size = 256M/g'
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/upload_max_filesize =.*/upload_max_filesize = 256M/g'
locate php.ini | grep '/opt/cpanel/ea-php' | grep '/root/etc/' | xargs sed -i 's/; max_input_vars = 1000/max_input_vars = 10000/g'
yum install -y ea-php54-php-bcmath ea-php54-php-bz2 ea-php54-php-calendar ea-php54-php-core ea-php54-php-ctype ea-php54-php-curl ea-php54-php-date ea-php54-php-dba ea-php54-php-dom ea-php54-php-enchant ea-php54-php-ereg ea-php54-php-exif ea-php54-php-fileinfo ea-php54-php-filter ea-php54-php-ftp ea-php54-php-gd ea-php54-php-gettext ea-php54-php-gmp ea-php54-php-hash ea-php54-php-i360 ea-php54-php-iconv  ea-php54-php-intl ea-php54-php-ioncube ea-php54-php-json ea-php54-php-ldap ea-php54-php-libxml ea-php54-php-mbstring ea-php54-php-mcrypt ea-php54-php-mhash ea-php54-php-mysql ea-php54-php-mysqli ea-php54-php-mysqlnd ea-php54-php-odbc ea-php54-php-openssl ea-php54-php-pcntl ea-php54-php-pcre ea-php54-php-pdo ea-php54-php-pdo_mysql ea-php54-php-pdo_odbc ea-php54-php-pdo_sqlite ea-php54-php-phar ea-php54-php-posix ea-php54-php-pspell ea-php54-php-readline ea-php54-php-reflection ea-php54-php-session ea-php54-php-shmop ea-php54-php-simplexml ea-php54-php-snmp ea-php54-php-soap ea-php54-php-sockets ea-php54-php-spl ea-php54-php-sqlite3 ea-php54-php-standard ea-php54-php-suhosin ea-php54-php-sysvmsg ea-php54-php-sysvsem ea-php54-php-sysvshm ea-php54-php-tidy ea-php54-php-tokenizer ea-php54-php-wddx ea-php54-php-xml ea-php54-php-xmlreader ea-php54-php-xmlrpc ea-php54-php-xmlwriter ea-php54-php-xsl ea-php54-php-zip ea-php54-php-zlib ea-php55-php-bcmath ea-php55-php-bz2 ea-php55-php-calendar ea-php55-php-core ea-php55-php-ctype ea-php55-php-curl ea-php55-php-date ea-php55-php-dba ea-php55-php-dom ea-php55-php-enchant ea-php55-php-ereg ea-php55-php-exif ea-php55-php-fileinfo ea-php55-php-filter ea-php55-php-ftp ea-php55-php-gd ea-php55-php-gettext ea-php55-php-gmp ea-php55-php-hash ea-php55-php-i360 ea-php55-php-iconv ea-php55-php-intl ea-php55-php-ioncube ea-php55-php-json ea-php55-php-ldap ea-php55-php-libxml ea-php55-php-mbstring ea-php55-php-mcrypt ea-php55-php-mhash ea-php55-php-mysql ea-php55-php-mysqli ea-php55-php-mysqlnd ea-php55-php-odbc ea-php55-php-openssl ea-php55-php-pcntl ea-php55-php-pcre ea-php55-php-pdo ea-php55-php-pdo_mysql ea-php55-php-pdo_odbc ea-php55-php-pdo_sqlite ea-php55-php-phar ea-php55-php-posix ea-php55-php-pspell ea-php55-php-readline ea-php55-php-reflection ea-php55-php-session ea-php55-php-shmop ea-php55-php-simplexml ea-php55-php-snmp ea-php55-php-soap ea-php55-php-sockets ea-php55-php-spl ea-php55-php-sqlite3 ea-php55-php-standard ea-php55-php-suhosin ea-php55-php-sysvmsg ea-php55-php-sysvsem ea-php55-php-sysvshm ea-php55-php-tidy ea-php55-php-tokenizer ea-php55-php-wddx ea-php55-php-xml ea-php55-php-xmlreader ea-php55-php-xmlrpc ea-php55-php-xmlwriter ea-php55-php-xsl ea-php55-php-zip ea-php55-php-zlib ea-php56-php-bcmath ea-php56-php-bz2 ea-php56-php-calendar ea-php56-php-core ea-php56-php-ctype ea-php56-php-curl ea-php56-php-date ea-php56-php-dba ea-php56-php-dom ea-php56-php-enchant ea-php56-php-ereg ea-php56-php-exif ea-php56-php-fileinfo ea-php56-php-filter ea-php56-php-ftp ea-php56-php-gd ea-php56-php-gettext ea-php56-php-gmp ea-php56-php-hash ea-php56-php-i360 ea-php56-php-iconv ea-php56-php-intl ea-php56-php-ioncube ea-php56-php-json ea-php56-php-ldap ea-php56-php-libxml ea-php56-php-mbstring ea-php56-php-mcrypt ea-php56-php-mhash ea-php56-php-mysql ea-php56-php-mysqli ea-php56-php-mysqlnd ea-php56-php-odbc ea-php56-php-openssl ea-php56-php-pcntl ea-php56-php-pcre ea-php56-php-pdo ea-php56-php-pdo_mysql ea-php56-php-pdo_odbc ea-php56-php-pdo_sqlite ea-php56-php-phar ea-php56-php-posix ea-php56-php-pspell ea-php56-php-readline  ea-php56-php-reflection ea-php56-php-session ea-php56-php-shmop ea-php56-php-simplexml ea-php56-php-snmp ea-php56-php-soap ea-php56-php-sockets ea-php56-php-spl ea-php56-php-sqlite3 ea-php56-php-standard ea-php56-php-suhosin ea-php56-php-sysvmsg ea-php56-php-sysvsem ea-php56-php-sysvshm ea-php56-php-tidy ea-php56-php-tokenizer ea-php56-php-wddx ea-php56-php-xml ea-php56-php-xmlreader ea-php56-php-xmlrpc ea-php56-php-xmlwriter ea-php56-php-xsl ea-php56-php-zip ea-php56-php-zlib ea-php70-php-bcmath ea-php70-php-bz2 ea-php70-php-calendar ea-php70-php-core ea-php70-php-ctype ea-php70-php-curl ea-php70-php-date ea-php70-php-dba ea-php70-php-dom ea-php70-php-enchant ea-php70-php-ereg ea-php70-php-exif ea-php70-php-fileinfo ea-php70-php-filter ea-php70-php-ftp ea-php70-php-gd ea-php70-php-gettext ea-php70-php-gmp ea-php70-php-hash ea-php70-php-i360 ea-php70-php-iconv  ea-php70-php-intl ea-php70-php-ioncube ea-php70-php-json ea-php70-php-ldap ea-php70-php-libxml ea-php70-php-mbstring ea-php70-php-mcrypt ea-php70-php-mhash ea-php70-php-mysql ea-php70-php-mysqli ea-php70-php-mysqlnd ea-php70-php-odbc ea-php70-php-openssl ea-php70-php-pcntl ea-php70-php-pcre ea-php70-php-pdo ea-php70-php-pdo_mysql ea-php70-php-pdo_odbc ea-php70-php-pdo_sqlite ea-php70-php-phar ea-php70-php-posix ea-php70-php-pspell ea-php70-php-readline ea-php70-php-reflection ea-php70-php-session ea-php70-php-shmop ea-php70-php-simplexml ea-php70-php-snmp ea-php70-php-soap ea-php70-php-sockets ea-php70-php-spl ea-php70-php-sqlite3 ea-php70-php-standard ea-php70-php-suhosin ea-php70-php-sysvmsg ea-php70-php-sysvsem ea-php70-php-sysvshm ea-php70-php-tidy ea-php70-php-tokenizer ea-php70-php-wddx ea-php70-php-xml ea-php70-php-xmlreader ea-php70-php-xmlrpc ea-php70-php-xmlwriter ea-php70-php-xsl ea-php70-php-zip ea-php70-php-zlib

