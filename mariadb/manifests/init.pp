# MariaDB
# =======
#
class mariadb::server {
  package {"mariadb-server": ensure => installed }
  service {"mysql":
    ensure  => running,
    require => Package["mariadb-server"]
  }

  file {"/etc/mysql/conf.d/bind-extern.cnf":
    ensure  => present,
    content => template("mariadb/etc/mysql/conf.d/bind-extern.cnf"),
    require => Package["mariadb-server"],
    notify  => Service["mysql"]
  }
}

#
# Installs the package mariadb-client.
#
class mariadb::client {
  package {"mariadb-client": ensure => installed }
}
