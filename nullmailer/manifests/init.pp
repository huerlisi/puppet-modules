# Nullmailer
# ==========
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
