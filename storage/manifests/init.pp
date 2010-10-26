# Storage
# =======
#
# Checks if the directory /srv/$network/ exists.
#
# Parameters 
# $network
# Name of the network.
#
class storage::base {
	file { "/srv/$network/":
		ensure => directory
	}
}

#
# Checks if the directory /srv/$network/$name exists.
#
# Parameters
# $network
# Name of the network
# $name
# Name of the server.
#
# Requires
# storage::base
#
define storage::srv() {
	include base
	file { "/srv/$network/$name":
		ensure  => directory,
		require => File["/srv/$network"]
	}
}

#
# ???
#
class storage::homes {
	srv { "home": }

	nfs::export { "/srv/$network/home": client => "*.$network" }
}
