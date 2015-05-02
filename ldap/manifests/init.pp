# LDAP
# ====
#
# Checks if /etc/ldap exists and if it is a directory.
# Adds the file /etc/ldap/ldap.conf with content ldap/etc/ldap/ldap.conf.
#
class ldap::client {
	file {"/etc/ldap": ensure => directory}
	file {"/etc/ldap/ldap.conf":
		ensure  => file,
		content => template("ldap/etc/ldap/ldap.conf"),
		require => File["/etc/ldap"]
	}
}

#
# Installs the package ldap-utils.
# 
# Requires
# ldap::client
#
class ldap::utils {
	include ldap::client
	package {"ldap-utils": ensure => installed}
}

#
# Installs the package slapd.
# Starts the service slapd.
# Adds the file /etc/ldap/slapd.conf with content ldap/etc/ldap/slapd.conf and
# root as owner with group openldap and mode 640.
# Checks if /etc/ldap/slapd.conf.d is a directory.
# Adds the file /etc/ldap/slapd.conf.d/options with the content 
# ldap/etc/ldap/slapd.conf.d/options.
# Depended on the $lsbdistcodename it creates a file named /etc/default/slapd
# with content ldap/etc/default/slapd.
#
# Parameters
# $lsbdistcodename
# Name of the distribution.
#
# Requires
# ldap::utils
#
class ldap::server {
        package {"slapd": ensure => installed}

	service {"slapd":
		ensure  => running,
		require => Package["slapd"]
	}

	file {"/etc/ldap/slapd.conf":
		ensure  => file,
		owner   => 'root',
		group   => 'openldap',
		mode    => '640',
		content => template("ldap/etc/ldap/slapd.conf"),
		require => Package["slapd"],
		notify  => Service["slapd"]
	}

	file {"/etc/ldap/slapd.conf.d":
		ensure  => directory,
		require => Package["slapd"]
	}

	file {"/etc/ldap/slapd.conf.d/options":
		ensure  => file,
		content => template("ldap/etc/ldap/slapd.conf.d/options"),
		require => [ Package["slapd"], File["/etc/ldap/slapd.conf.d"] ],
		notify  => Service["slapd"]
	}

  file {"/etc/default/slapd":
    ensure  => file,
    content => template("ldap/etc/default/slapd"),
    require => Package["slapd"],
    notify  => Service["slapd"]
  }

	include ldap::utils
}

#
# Installs the packages phpldapadmin and php5-mhash.
# Checks if the service apache2 is running.
#
# Requires
# apache::server
#
class ldap::phpldapadmin {
	include apache::server

	package { "phpldapadmin":
		ensure => installed,
		notify  => Service["apache2"]
	}

	package { "php5-mhash":
		ensure => installed,
		notify  => Service["apache2"]
	}
}

#
# Installs the package libpam-ldap.
# Adds the files /etc/pam_ldap.conf and /etc/ldap.conf with content ldap/etc/pam_ldap.conf.
# Adds the files /etc/pam.d/common-account with content ldap/etc/pam.d/common-account, 
# /etc/pam.d/common-auth with content ldap/etc/pam.d/common-auth, 
# /etc/pam.d/common-password with content ldap/etc/pam.d/common-password and 
# /etc/pam.d/common-session with content ldap/etc/pam.d/common-session.
#
# Requires
# ldap::client
# ldap::nss
#
class ldap::pam {
	include ldap::client
	include ldap::nss

	package {"libpam-ldap": ensure => installed}

	file {["/etc/pam_ldap.conf", "/etc/ldap.conf"]:
		content => template("ldap/etc/pam_ldap.conf")
	}

	file { "/etc/pam.d/common-account":
	        content => template("ldap/etc/pam.d/common-account")
	}
	file { "/etc/pam.d/common-auth":
        	content => template("ldap/etc/pam.d/common-auth")
	}
	file { "/etc/pam.d/common-password":
	        content => template("ldap/etc/pam.d/common-password")
	}
	file { "/etc/pam.d/common-session":
	        content => template("ldap/etc/pam.d/common-session")
	}
}

#
# Installs the package libnss-ldapd.
# Starts the service nslcd.
# Depended on the $lsbdistcodename it creates a file.
#
#  Case karmic or lucid
#  Installs the package nslcd and creates the file /etc/nslcd.conf and /etc/nss-ldapd.conf
#  with content ldap/etc/nss-ldapd.conf
#
#  Case default Creates the file /etc/nss-ldapd.conf with content ldap/etc/nss-ldapd.conf.
#  
#
class ldap::nslcd {
        package {"nslcd": ensure => installed}
        file {["/etc/nslcd.conf", "/etc/nss-ldapd.conf"]:
                content => template("ldap/etc/nss-ldapd.conf"),
                notify  => Service["nslcd"]
        }

	service {"nslcd":
		ensure  => running,
		require => Package["libnss-ldapd"]
	}

}

#
# Installs the package libnss-ldapd.
# Creates the file /etc/nsswitch.conf with content ldap/etc/nsswitch.conf.
#
# Requires
# ldap::nslcd
#
class ldap::nss {
	include ldap::nslcd

	package {"libnss-ldapd": ensure => installed}

	file {"/etc/nsswitch.conf":
		content => template("ldap/etc/nsswitch.conf")
	}
}
