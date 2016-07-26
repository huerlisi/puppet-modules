# Samba
# =====
class samba::server {
}

class samba::client {
  package { "cifs-utils": ensure => installed }
}
