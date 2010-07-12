# Ruby on Rails
# =============

# Install ruby on rails framework.
#
# Depends on:
#   - apache2
#   - passenger
class rails::framework {
	package {"rails":
		ensure => installed
	}
}

class rails::webapp {
	include rails::framework
	include apache2::server
	include passenger::apache2
}

# Rails 3
class rails3::framework {
	package {"rubygems": ensure => present}

	package {"rails":
		provider => 'gem',
		ensure   => '3.0.0.beta4',
		require  => Package["rubygems"]
	}
}

class rails3::webapp {
	include rails3::framework
	include apache2::server
	include passenger::apache2
}

