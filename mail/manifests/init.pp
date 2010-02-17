# Mail
# ====
class mail::client {
	case $lsbdistcodename {
		'hardy': { package {"mailx": ensure => installed } }
		default: { package {"bsd-mailx": ensure => installed} }
	}

	file {"/etc/mailname": content => $mail_domain}
}
