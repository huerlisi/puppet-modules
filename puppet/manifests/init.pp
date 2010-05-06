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

class puppet::store {
	import "mysql"

	@@mysql_database { "puppet": ensure => present, tag => 'infra01.dmz' }
	@@mysql_user { "puppet@$fqdn":
		ensure        => present,
		password_hash => '*362C0A1E240F3149F49DF9B55A3D53E1CD0B7E49',
		tag => 'infra01.dmz'
	}
	@@mysql_grant { "puppet@$fqdn/puppet": privileges => 'all', tag => 'infra01.dmz' }
}
