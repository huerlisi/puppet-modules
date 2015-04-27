# Ruby on Rails
# =============
#
# Rails 3

class rails::framework($default_hostname = false) {
  include nginx::server
  include mysql::client

	package {"ruby1.9.3": ensure => present}
	package {["build-essential", "ruby1.9.1-dev", "libssl-dev"]: ensure => present}

  # for capistrano-rbenv
  package {["lsb-release", "lsb-core", "libffi-dev"]: ensure => present}

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

	package {"foreman":
		ensure   => present,
		provider => gem,
		require  => [Package["ruby1.9.3"]]
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

	file { "/srv":
		ensure => directory,
		owner  => deployer
	}

  file { "/etc/nginx/sites-available/rails":
		content => template('rails/nginx/sites-available/rails.erb'),
		require  => Package["nginx"],
		notify   => Service["nginx"]
	}

	file { "/etc/nginx/sites-enabled/rails":
		ensure => '../sites-available/rails'
	}

	file { "/etc/nginx/sites-enabled/default": ensure => absent }

	package {["nodejs", "libpq-dev", "libmysqlclient-dev", "libsqlite3-dev", "libxml2-dev", "libxslt1-dev", "libmagickcore-dev", "libmagickwand-dev", "gawk", "sphinxsearch", "catdoc"]: ensure => present}

  file { "/etc/logrotate.d/rails":
    content => template('rails/etc/logrotate.d/rails')
  }
}
