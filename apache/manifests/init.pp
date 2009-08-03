# Apache
# ======
class apache::server {
        package {"apache2": ensure => installed }
        service {"apache2":
                ensure  => running,
                require => Package["apache2"]
        }
}

# Apache modules
# ==============
define apache2_module() {
        file { "/etc/apache2/mods-enabled/$title":
                ensure  => "/etc/apache2/mods-available/$title",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

class apache2::mod_ldap {
        file { "/etc/apache2/mods-enabled/authnz_ldap.load":
                ensure  => "/etc/apache2/mods-available/authnz_ldap.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }

        file { "/etc/apache2/mods-enabled/ldap.load":
                ensure  => "/etc/apache2/mods-available/ldap.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

class apache2::mod_deflate {
        file { "/etc/apache2/mods-enabled/deflate.load":
                ensure  => "/etc/apache2/mods-available/deflate.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
        file { "/etc/apache2/mods-enabled/deflate.conf":
                ensure  => "/etc/apache2/mods-available/deflate.conf",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

class apache2::mod_proxy {
        file { "/etc/apache2/mods-enabled/proxy.load":
                ensure  => "/etc/apache2/mods-available/proxy.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
        file { "/etc/apache2/mods-enabled/proxy.conf":
                ensure  => "/etc/apache2/mods-available/proxy.conf",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
        file { "/etc/apache2/mods-enabled/proxy_http.load":
                ensure  => "/etc/apache2/mods-available/proxy_http.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}
