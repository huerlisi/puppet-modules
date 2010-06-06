# Zarafa
# ======
class zarafa::apt {
	apt::deb-list {"canonical-lucid-partner":
		repository => "http://archive.canonical.com/ubuntu",
		components => ["partner"]
	}
}

class zarafa::mysql {
	@@mysql_database { "zarafa_$zone": ensure => present, tag => "mysql_$db_zone" }
	@@mysql_user { "zarafa@$hostname.$network":
		ensure        => present,
		password_hash => mysql_password($mysql_password),
		tag           => "mysql_$db_zone"
	}
	@@mysql_grant { "zarafa@$hostname.$network/zarafa_$zone": privileges => 'all', tag => "mysql_$db_zone" }
}

class zarafa::postfix {
	$mailbox_delivery = 'zarafa'
	include postfix::server

	user {"zarafa-postfix": ensure => present }
}

class zarafa::openldap {
	include zarafa::server

	file {"/etc/zarafa/ldap.openldap.cfg":
		ensure => file,
		content => template("zarafa/etc/zarafa/ldap.openldap.cfg"),
		require => Package["zarafa"],
		notify  => Service["zarafa-server"]
	}
}

class zarafa::server {
	include zarafa::apt
	include zarafa::mysql
	if $zarafa_ldap {
		include openldap
	}
	$zarafa_user_plugin = $zarafa_ldap ? {
		true => 'ldap',
		default => 'db'
	}

	package {"zarafa":
		ensure  => installed,
		require => Apt::Deb-list["canonical-lucid-partner"]
	}

	service {"zarafa-server":
		ensure  => running,
		require => Package["zarafa"]
	}

	file {"/etc/zarafa/server.cfg":
		ensure => present,
		mode => "0640",
		owner => "root",
		content => template("zarafa/etc/zarafa/server.cfg"),
		require => Package["zarafa"],
		notify  => Service["zarafa-server"]
	}
}

class zarafa::webapp inherits php::apache2 {
	include zarafa::apt

	package {"zarafa-webaccess":
		ensure  => installed,
		require => Apt::Deb-list["canonical-lucid-partner"]
	}
}

