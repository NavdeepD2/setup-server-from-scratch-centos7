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
