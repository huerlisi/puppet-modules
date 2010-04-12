# Zarafa
# ======
class zarafa::webapp inherits php::apache2 {
	include mysql::server

	package {"zarafa-webaccess":
		ensure  => installed,
		require => Apt::Ppa["huerlisi-ppa"]
	}
}
