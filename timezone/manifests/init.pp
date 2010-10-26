# Timezone
# ========
#
# Installs the package tzdata.
# Adds the file /etc/localtime.
# ???
#
class timezone::conf {
	package { "tzdata": ensure => installed }

	file { "/etc/localtime":
		ensure => "/usr/share/zoneinfo/$default_timezone",
		force  => true
	}
}
