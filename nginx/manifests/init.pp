# nginx
# =====
#
# Installs the package nginx and starts the service.
#
class nginx::server {
        package {"nginx": ensure => installed }
        service {"nginx":
                ensure  => running,
                require => Package["nginx"]
        }
}
