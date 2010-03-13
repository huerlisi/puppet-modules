# Redmine
# =======
class redmine::webapp {
	package {["redmine", "redmine-mysql", "librmagick-ruby"]: ensure => installed }
}
