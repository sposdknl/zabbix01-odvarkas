#!/bin/bash
set -e

apt update && apt upgrade -y
apt install -y wget gnupg

wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1+debian12_all.deb
dpkg -i zabbix-release_7.0-1+debian12_all.deb
apt update

apt install -y zabbix-agent2

mkdir -p /var/log/zabbix
chown zabbix:zabbix /var/log/zabbix

cat > /etc/zabbix/zabbix_agent2.conf << 'EOF'
PidFile=/var/run/zabbix/zabbix_agent2.pid
LogFile=/var/log/zabbix/zabbix_agent2.log
LogFileSize=10
Server=enceladus.pfsense.cz
ServerActive=enceladus.pfsense.cz
Hostname=odvarka
HostMetadata=SPOS
TLSConnect=unencrypted
TLSAccept=unencrypted
DebugLevel=3
EOF

chown zabbix:zabbix /etc/zabbix/zabbix_agent2.conf
chmod 644 /etc/zabbix/zabbix_agent2.conf

systemctl restart zabbix-agent2
systemctl enable zabbix-agent2