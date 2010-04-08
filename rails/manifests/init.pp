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
