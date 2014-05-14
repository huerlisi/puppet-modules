# Obnam Backup

class obnam::client {
  package { 'obnam': ensure => installed }

  file { '/etc/obnam': ensure => directory } ~>
  file { '/etc/obnam/00-system.conf':
    content => template('obnam/etc/obnam/00-system.conf.erb')
  }
}
