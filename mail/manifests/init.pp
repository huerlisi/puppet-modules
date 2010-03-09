# Mail
# ====
class mail::client {
	case $lsbdistcodename {
		'hardy': { package {"mailx": ensure => installed } }
		default: { package {"bsd-mailx": ensure => installed} }
	}

	include mail::mailname
}

class mail::mailname {
	file {"/etc/mailname": content => $fqdn}
}
