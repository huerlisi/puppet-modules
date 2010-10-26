# Zarafa
# ======
#
# Add the canonical-lucid-partner to the repository list.
# 
# Requires
#   apt::deb-list
#
class zarafa::apt {
	apt::deb-list {"canonical-lucid-partner":
		repository => "http://archive.canonical.com/ubuntu",
		components => ["partner"]
	}
}

#
# Ensures that there is a Mysql database, zarafa_$zone and a user zarafa. 
# It sets the mysql password and grant all needed privileges.
#
# Parameters:
#   $zone:
#     
#   $db_zone:
#     Zone where server is located.
#   $hostname:
#     Name of the Host. But just the host and not the domain!
#   $network:
#     Name of the domain.
#   $mysql_password
#     The mysql password.
#
class zarafa::mysql {
	@@mysql_database { "zarafa_$zone": ensure => present, tag => "mysql_$db_zone" }
	@@mysql_user { "zarafa@$hostname.$network":
		ensure        => present,
		password_hash => mysql_password($mysql_password),
		tag           => "mysql_$db_zone"
	}
	@@mysql_grant { "zarafa@$hostname.$network/zarafa_$zone": privileges => 'all', tag => "mysql_$db_zone" }
}

#
# Ensures that needed user exists and include the class postfix::server.
#
# Parameters:
#   $mailbox_delivery
#
# Requires:
#   postfix::server
#
class zarafa::postfix {
	$mailbox_delivery = 'zarafa'
	include postfix::server

	user {"zarafa-postfix": ensure => present }
}

#
# Ensures that the needed file '/etc/zarafa/ldap.openldap.cfg' exists and 
# include the class zarafa::server. It notifies the Service Zarafa-server and
# install the package zarafa
#
class zarafa::openldap {
	include zarafa::server


	file {"/etc/zarafa/ldap.openldap.cfg":
		ensure => file,
		content => template("zarafa/etc/zarafa/ldap.openldap.cfg"),
		require => Package["zarafa"],
		notify  => Service["zarafa-server"]
	}
}

#
# Controlls if all services were running and all packages would be installed.
# Includes zarafa::apt, zarafa::mysql and openldap.
# Ensures package zarafa is installed and the service zarafa-server runs.
# Check if /etc/zarafa/server.cfg exists.
# Notify the Service zarafa-server.
#
# Parameters:
#   $zarafa_ldap
#
#   $zarafa_user_plugin
#
# Requires:
#   - Apt::Deb-list["canonical-lucid-partner"]
#   - Package["zarafa"]
#
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

#
# Checks if zarafa-webaccess is installed.
# Includes zarafa::apt.
# Inhertits php:apache2.
#
# Requires:
#   Apt::Deb-list["canonical-lucid-partner"]
#
class zarafa::webapp inherits php::apache2 {
	include zarafa::apt

	package {"zarafa-webaccess":
		ensure  => installed,
		require => Apt::Deb-list["canonical-lucid-partner"]
	}
}

