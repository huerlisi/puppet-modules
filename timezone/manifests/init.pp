# Timezone
# ========
class timezone::conf {
	package { "tzdata": ensure => installed }

	file { "/etc/localtime":
		ensure => "/usr/share/zoneinfo/$default_timezone",
		force  => true
	}
}
