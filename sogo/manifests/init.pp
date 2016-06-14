# SOGO
# ====

# Add sogo/inverse sources by hand
class sogo:server {
  package {"sogo": ensure => installed }

  package {["apache2", "memcached"]: ensure => installed }
}
