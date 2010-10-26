# Nagios
# ======
#
# Installs the package nagios3.
#
class nagios::server {
	package {"nagios3": ensure => installed}
}
