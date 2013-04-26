# Ruby on Rails
# =============

# Rails 3
#
class rails::framework {
        include git::client
        include nginx::server
        include mysql::client

	package {"ruby1.9.3": ensure => present}
	package {["build-essential", "ruby1.9.1-dev"]: ensure => present}
	package {"rsync": ensure => present}
	package {"bundler":
		ensure   => present,
		provider => gem,
		require  => Package["ruby1.9.3"]
	}

	package {"unicorn":
		ensure   => present,
		provider => gem,
		require  => [Package["ruby1.9.3"], Package["ruby1.9.1-dev"]]
	}

	package {"bluepill":
		ensure   => present,
		provider => gem,
		require  => [Package["ruby1.9.3"]]
	}

	file { "/var/run/bluepill":
		ensure => directory,
		owner  => deployer
	}

	package {"nodejs": ensure => present}

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
