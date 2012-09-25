# Ruby on Rails
# =============

# Rails 3
#
class rails::framework {
        include git::client
        include nginx::server
	include runit::daemon

	package {"rubygems": ensure => present}
	file { "/srv":
		ensure => directory,
		owner  => deployer
	}

        file { "/etc/nginx/sites-available/rails":
		content => template('rails/nginx/sites-available/rails'),
		require  => Package["nginx"],
		notify   => Service["nginx"]
	}

	file { "/etc/nginx/sites-enabled/rails":
		ensure => '../sites-available/rails'
	}
}
