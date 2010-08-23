# Apache
# ======
class apache2::server {
        package {"apache2": ensure => installed }
        service {"apache2":
                ensure  => running,
                require => Package["apache2"]
        }
}

# Apache sites
# ============
define apache2::site($template) {
	file { "/etc/apache2/sites-available/$title":
		ensure  => file,
		content => template($template),
                require => Package["apache2"]
	}

        file { "/etc/apache2/sites-enabled/$title":
                ensure  => "../sites-available/$title",
                notify  => Service["apache2"],
                require => File["/etc/apache2/sites-available/$title"]
        }
}

# Apache modules
# ==============
define apache2::module() {
        file { "/etc/apache2/mods-enabled/$title":
                ensure  => "../mods-available/$title",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

class apache2::mod_ldap {
        file { "/etc/apache2/mods-enabled/authnz_ldap.load":
                ensure  => "../mods-available/authnz_ldap.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }

        file { "/etc/apache2/mods-enabled/ldap.load":
                ensure  => "../mods-available/ldap.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

class apache2::mod_deflate {
        file { "/etc/apache2/mods-enabled/deflate.load":
                ensure  => "../mods-available/deflate.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
        file { "/etc/apache2/mods-enabled/deflate.conf":
                ensure  => "../mods-available/deflate.conf",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

class apache2::mod_proxy {
        file { "/etc/apache2/mods-enabled/proxy.load":
                ensure  => "../mods-available/proxy.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
        file { "/etc/apache2/mods-enabled/proxy.conf":
                ensure  => "../mods-available/proxy.conf",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
        file { "/etc/apache2/mods-enabled/proxy_http.load":
                ensure  => "../mods-available/proxy_http.load",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}
