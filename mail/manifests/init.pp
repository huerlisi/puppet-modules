# Mail
# ====
class mail::client {
	package {"bsd-mailx": ensure => installed}
}
