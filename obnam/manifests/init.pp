# Obnam Backup

class obnam::client($id_rsa = undef, $known_hosts = undef) {
  package { 'obnam': ensure => installed }

  file { '/etc/obnam': ensure => directory }

  # Configuration and profiles
  file { '/etc/obnam/00-system.conf':
    content => template('obnam/etc/obnam/00-system.conf.erb'),
    require => File['/etc/obnam']
  }
  file { '/etc/obnam/host.profile':
    content => template('obnam/etc/obnam/host.profile.erb'),
    require => File['/etc/obnam']
  }

  # Authorization
  if $id_rsa {
    file { '/etc/obnam/id_rsa.obnam':
      content => $id_rsa,
      mode    => '0600',
      require => File['/etc/obnam']
    }
  }
  if $known_hosts {
    file { '/etc/obnam/known_hosts':
      content => $known_hosts,
      require => File['/etc/obnam']
    }
  }

  # Scheduler
  file { '/etc/cron.d/obnam-host':
    content => template('obnam/etc/cron.d/obnam-host'),
    require => File['/etc/obnam']
  }
}
