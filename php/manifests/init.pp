# PHP
# ===
#
# Installs the package php5.
#
class php::base {
	package { "php5": ensure => installed }
}

#
# Installs the package libapache2-mod-php5.
#
class php::apache2 {
	package { "libapache2-mod-php5": ensure => installed }
}

# Modules
# =======
# Should probably implemented using virtual resources or something...

#
# Installs the package php5-gd.
#
class php::gd {
	package {"php5-gd": ensure => installed}
}

#
# Installs the package php5-mysql.
#
class php::mysql {
	package {"php5-mysql": ensure => installed}
}

#
# Installs the package php5-imagick.
#
class php::imagick {
	package {"php5-imagick": ensure => installed}
}
