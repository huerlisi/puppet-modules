# MySQL
# =====
class mysql::server {
        package {"mysql-server": ensure => installed }
}

class mysql::client {
        package {"mysql-client": ensure => installed }
}
