# Redmine
# =======
class redmine::webapp {
	package {["redmine", "redmine-mysql"]: ensure => installed }
}
