# Zarafa
# ======
class zarafa::apt {
	apt::deb-list {"canonical-lucid-partner":
		repository => "http://archive.canonical.com/ubuntu",
		components => ["partner"]
	}
}

class zarafa::mysql {
	@@mysql_database { "zarafa": ensure => present, tag => "mysql_$zone" }
	@@mysql_user { "zarafa@$hostname.$network":
		ensure        => present,
		password_hash => mysql_password($mysql_password),
		tag           => "mysql_$zone"
	}
	@@mysql_grant { "zarafa@$hostname.$network/zarafa": privileges => 'all', tag => "mysql_$zone" }
}

class zarafa::server {
	include zarafa::apt
	include zarafa::mysql

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
