# Redmine
# =======
class redmine::mysql {
	@@mysql_database { "redmine_$zone": ensure => present, tag => "mysql_$db_zone" }
	@@mysql_user { "redmine@$hostname.$network":
		ensure        => present,
		password_hash => mysql_password($mysql_password),
		tag           => "mysql_$db_zone"
	}
	@@mysql_grant { "redmine@$hostname.$network/redmine_$zone": privileges => 'all', tag => "mysql_$db_zone" }
}

class redmine::webapp inherits rails::webapp {
	include redmine::mysql

	package {"redmine-mysql":
		ensure  => installed
	}

	package {"redmine":
		ensure  => installed,
		require => Package["redmine-mysql"],
		notify  => Exec["Set www-data as owner of environment.rb"]
	}

	exec {"Set www-data as owner of environment.rb":
		command => "sudo dpkg-statoverride --update --add www-data root 644 /usr/share/redmine/config/environment.rb",
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
		refreshonly => true,
		notify      => Service["apache2"]
	}
}
