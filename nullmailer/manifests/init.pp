# Nullmailer
# ==========
#
# Installs the package nullmailer.
# Adds the file /etc/nullmailer/remotes with content nullmailer/etc/nullmailer/remotes.
# Ads the file /etc/nullmailer/adminaddr with content nullmailer/etc/nullmailer/adminaddr.
#
class nullmailer::server {
        package {"nullmailer": ensure => installed }

        file { "/etc/nullmailer/remotes":
                content => template('nullmailer/etc/nullmailer/remotes'),
		require => Package["nullmailer"]
        }
        file { "/etc/nullmailer/adminaddr":
                content => template('nullmailer/etc/nullmailer/adminaddr'),
		require => Package["nullmailer"]
        }
}
