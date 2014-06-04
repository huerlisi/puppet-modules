# rbenv
# =====
#
# This module provides rbenv support to use multiple versions of ruby.

class rails::rbenv {
  rbenv::install { "deployer":
    group => 'deployer',
    home  => '/srv'
  }
  rbenv::compile { "deployer/2.1.2":
    user => "deployer",
    ruby => "2.1.2",
    home  => '/srv'
  }
  rbenv::compile { "deployer/2.0.0-p247":
    user => "deployer",
    ruby => "2.0.0-p247",
    home  => '/srv'
  }
	package {"rbenv": ensure => present}
}
