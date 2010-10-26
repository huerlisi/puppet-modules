# Phusion Passenger
# =================

# 
# Installs the package libapache2-mod-passenger
# Starts the service apache2.
#
# Requires
# apache2::server
#
class passenger::apache2 {
	include apache2::server

	package {"libapache2-mod-passenger":
		ensure => installed,
		notify => Service["apache2"]
	}
}
