# Phusion Passenger
# =================

# Install apache2 passenger module.
#
# Depends on:
#   - apache2
class passenger::apache2 {
	include apache2::server

	package {"libapache2-mod-passenger":
		ensure => installed,
		notify => Service["apache2"]
	}
}
