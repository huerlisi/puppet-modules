# PHP
# ===
class php::base {
	package { "php5": ensure => installed }
}

class php::apache2 {
	package { "libapache2-mod-php5": ensure => installed }
}

# Modules
# =======
# Should probably implemented using virtual resources or something...

class php::gd {
	package {"php5-gd": ensure => installed}
}

class php::mysql {
	package {"php5-mysql": ensure => installed}
}

class php::imagick {
	package {"php5-imagick": ensure => installed}
}
