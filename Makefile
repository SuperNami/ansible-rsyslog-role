rsyslog: install-uptodate configure-fluentd

install-old: install-rsyslog config-rsyslog
install-uptodate: stable-repo install-rsyslog config-rsyslog
compile: compile-source config-rsyslog

configure-standalone: config-default config-ufw config-cloudinit
configure-fluentd: config-fluentd

debian-repo:
	ansible-playbook main.yml -i localhost -t debian_repo

devel-repo:
	ansible-playbook main.yml -i localhost -t devel_repo

stable-repo:
	ansible-playbook main.yml -i localhost -t stable_repo

install-rsyslog:
	ansible-playbook main.yml -i localhost -t install_rsyslog

compile-source:
	ansible-playbook main.yml -i localhost -t install_rsyslog_source

config-rsyslog:
	ansible-playbook main.yml -i localhost -t configure_rsyslog

config-default:
	ansible-playbook main.yml -i localhost -t configure_default

config-fluentd:
	ansible-playbook main.yml -i localhost -t configure_fluentd

config-ufw:
	ansible-playbook main.yml -i localhost -t configure_ufw

config-cloudinit:
	ansible-playbook main.yml -i localhost -t configure_cloudinit

check-config:
	rsyslogd -N1 && rsyslogd -N6

check-errors:
	cat /var/log/rsyslog.conf

check-local-network:
	tcpdump -i lo host 127.0.0.1 and udp port 514

check-remote-network:
	tcpdump -i lo host 192.168.x.x and udp port 514

check-port:
	netstat -peanut | grep ":514"

start:
	/etc/init.d/rsyslog start

restart:
	/etc/init.d/rsyslog restart

stop:
	/etc/init.d/rsyslog stop

debug-log:
	rsyslogd -dn > logfile
