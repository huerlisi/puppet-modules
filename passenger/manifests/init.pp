# Phusion Passenger
# =================

# Install apache2 passenger module.
#
# Depends on:
#   - apache2
class apache2::passenger {
	include apache2::server

	package {"libapache2-passenger":
		ensure => installed,
		notify => Service["apache2"]
	}
}
