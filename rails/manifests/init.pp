# Ruby on Rails
# =============

# Install ruby on rails framework.
# Installs the package rails.
#
# Depends on:
#   - apache2
#   - passenger
class rails::framework {
}
#
# Requires
# rails::framework
# apache2::server
# passenger::apache2
#
class rails::webapp {
	include rails::framework
	include apache2::server
	include passenger::apache2
}

# Rails 3
# Installs the package rubygems.
# Installs the 3.0.0.beta4 package of rails.
#
class rails3::framework {
	package {"rubygems": ensure => present}
}

#
# Requires
# rails3::framework
# apache2::server
# passenger::apache2
#
class rails3::webapp {
	include rails3::framework
	include apache2::server
	include passenger::apache2
}
