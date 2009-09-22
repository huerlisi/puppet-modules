# Puppet
# ======
class puppet::server {
	include git::client

	package { "puppetmaster": ensure => installed }
	service { "puppetmaster":
		ensure  => running,
		require => Package["puppetmaster"]
	}

#	file { "/etc/puppet/fileserver.conf":
#		ensure  => file,
#		content => template('puppet/etc/puppet/fileserver.conf')
#	}

}
