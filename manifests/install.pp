# @!visibility private
class watchdog::install {

  if $watchdog::manage_package {
    package { $watchdog::package_name:
      ensure => present,
    }
  }
}
