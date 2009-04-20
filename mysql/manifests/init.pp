# MySQL
# =====
class mysql::server {
        package {"mysql-server": ensure => installed }
}

class mysql::client {
        package {"mysql-client": ensure => installed }
}

# Web admin
# =========
class mysql::phpmyadmin {
	package {"phpmyadmin": ensure => installed }
	include mysql::phpmyadmin::apache2
}

class mysql::phpmyadmin::apache2 {
	include apache::server

	file {"/etc/apache2/conf.d/phpmyadmin.conf":
		ensure  => "/etc/phpmyadmin/apache.conf",
		require => Package["phpmyadmin"],
		notify  => Service["apache2"]
	}
}
