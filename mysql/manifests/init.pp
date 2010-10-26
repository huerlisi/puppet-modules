# MySQL
# =====
#
# Installs the package mysql-server.
# Starts the service mysql.
# Adds the file /etc/mysql/conf.d/bind-extern.cnf with content 
# mysql/etc/mysql/conf.d/bind-extern.cnf.
#
class mysql::server {
        package {"mysql-server": ensure => installed }
	service {"mysql":
		ensure  => running,
		require => Package["mysql-server"]
	}

	file {"/etc/mysql/conf.d/bind-extern.cnf":
		ensure  => present,
		content => template("mysql/etc/mysql/conf.d/bind-extern.cnf"),
		require => Package["mysql-server"],
		notify  => Service["mysql"]
	}
}

#
# Installs the package mysql-client.
#
class mysql::client {
        package {"mysql-client": ensure => installed }
}

# Web admin
# =========
#
# Installs the package phpmyadmin
#
# Requires
# mysql::phpmyadmin::apache2
#
class mysql::phpmyadmin {
	package {"phpmyadmin": ensure => installed }
	include mysql::phpmyadmin::apache2
}

#
# Adds the file /etc/apache2/conf.d/phpmyadmin.conf with content /etc/phpmyadmin/apache.conf.
# Installs the package phpmyadmin.
# Starts the service apache2
#
# Requires
# apache::server
#
class mysql::phpmyadmin::apache2 {
	include apache::server

	file {"/etc/apache2/conf.d/phpmyadmin.conf":
		ensure  => "/etc/phpmyadmin/apache.conf",
		require => Package["phpmyadmin"],
		notify  => Service["apache2"]
	}
}
