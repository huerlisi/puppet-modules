# Mail
# ====
class mail::client {
	package {"bsd-mailx": ensure => installed}

	file {"/etc/mailname": content => $mail_domain}
}
