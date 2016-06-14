# Owncloud
# ========

# Add onwcloud sources by hand
class owncloud::server {
  package {"owncloud": ensure => installed }
}
