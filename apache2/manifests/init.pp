# Apache
# ======
#
# Installs the package apache2 and starts the service apache2.
#
class apache2::server {
        package {"apache2": ensure => installed }
        service {"apache2":
                ensure  => running,
                require => Package["apache2"]
        }
}

# Apache sites
# ============
#
# Creates the apachefiles in sites-enabled and sites-avaible.
# Add content from template.
# Checks if the service apache2 is running.
# Checks if the equal file for sites-enabled exists in sites-avaible.
#
# Parameters:
#  $title
#   Name of the added page.
#  $template
#   Template for default page.
#
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
#
# Enables a module of apache.
# Checks if the module exists in mods-avaible.
# Ensures the service apache2 is running and the package apache2 is installed.
#
define apache2::module() {
        file { "/etc/apache2/mods-enabled/$title":
                ensure  => "../mods-available/$title",
                notify  => Service["apache2"],
                require => Package["apache2"]
        }
}

#
# Checks if the modules authnz_ldap.load and ldap.load exists in mods avaible 
# and add them into mods-enabled.
# Ensures the service apache2 is running and the package apache2 is installed.
#
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

#
# Checks if the modules deflate.load and deflate.conf exists in mods avaible
# and add them into mods-enabled.
# Ensures the service apache2 is running and the package apache2 is installed.
#
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

#
# Checks if the modules proxy.load, proxy.conf and proxy_http.load exists in 
# mods avaible and add them into mods-enabled.
# Ensures the service apache2 is running and the package apache2 is installed.
#
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
