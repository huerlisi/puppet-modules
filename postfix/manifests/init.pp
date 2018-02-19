# Postfix
# =======
#
# Includes the Class mail::mailname.
# Ensures that the packages: postfix and postfix-pcre are installed.
# Check if the files: /etc/mailname, /etc/postfix/main.cf, /etc/postfix/master.cf
# and /etc/postfix/transport exist and have the right content.
#
# Require:
#   Packages: postfix
#
# Notify:
#   Service postfix
#
# Execute:
#   postfix transport mapping
#     /usr/sbin/postmap
#     /etc/postfix/transport
#
class postfix::server {
	include mail::mailname

        package {"postfix":
		ensure => installed,
		subscribe => File["/etc/mailname"]
	}
	package {"postfix-pcre": ensure => installed }

	service {"postfix":
		ensure  => running,
		require => Package["postfix"]
	}

	file {"/etc/postfix/main.cf":
		ensure  => present,
		content => template("postfix/etc/postfix/main.cf"),
		require => Package["postfix"],
		notify  => Service["postfix"]
	}
	file {"/etc/postfix/master.cf":
		ensure  => present,
		content => template("postfix/etc/postfix/master.cf"),
		require => Package["postfix"],
		notify  => Service["postfix"]
	}

	if $postfix_transport_map {
		exec {"postfix transport mapping":
			command     => "/usr/sbin/postmap /etc/postfix/transport",
			require     => Package["postfix"],
			refreshonly => true
		}
    file {"/etc/postfix/transport":
            ensure  => present,
            content => template("postfix/etc/postfix/transport"),
            require => Package["postfix"],
            notify  => Exec["postfix transport mapping"]
    }
	}

	if $postfix_sasl {
		include postfix::sasl
	}
}

# Plugins
# =======
#
# Include the class postfix::server.
# Ensure the package postfix-ldap is installed.
#
class postfix::ldap {
	include server
	
	package {"postfix-ldap": ensure => installed}
}

class postfix::sasl {
	include sasl::daemon

	file {"/etc/default/saslauthd-postfix_chroot":
		ensure  => present,
		content => template("postfix/etc/default/saslauthd"),
		notify  => Service["saslauthd"],
	}

	user {"postfix":
		groups     => 'sasl',
		require    => [Package["postfix"], Package["sasl2-bin"]],
		membership => minimum,
		notify     => Service["postfix"]
	}

	exec {"dpkg-statoverride --add root sasl 710 /var/spool/postfix/var/run/saslauthd":
		path   => ["/usr/bin", "/usr/sbin"],
		unless => "dpkg-statoverride --list root sasl 710 /var/spool/postfix/var/run/saslauthd"
	}
}

# Configurations
# ==============
#
# Include the class postfix::server.
#
# Parameters:
# $postfix_mydestination
#
# $postfix_mynetworks
#
# $friend_networks
#
class postfix::proxy {
	$postfix_mydestination = ''
	$postfix_mynetworks    = $friend_networks

	include server
}
