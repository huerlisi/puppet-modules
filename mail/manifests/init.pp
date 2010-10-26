# Mail
# ====
#
# Include the Class mail::mailname.
# Ensure the needed mailx package is installed
#
# Parameters:
# $lsbdistcodename
#   Checks if there is a Hardy or not and install the needed package.
#
class mail::client {
	case $lsbdistcodename {
		'hardy': { package {"mailx": ensure => installed } }
		default: { package {"bsd-mailx": ensure => installed} }
	}

	include mail::mailname
}

#
# Check if the file /etc/mailname exist.
#
# Parameters:
# $fqdn\n
#   Content of /etc/mailname
#
class mail::mailname {
	file {"/etc/mailname": content => "$fqdn\n"}
}
