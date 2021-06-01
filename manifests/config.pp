# @!visibility private
class watchdog::config {

  $period = $watchdog::period
  $tickle = floor($period / 3)

  case $facts['os']['family'] {
    'RedHat', 'Debian': {
      file { '/etc/watchdog.conf':
        ensure  => file,
        owner   => 0,
        group   => 0,
        mode    => '0644',
        content => epp('watchdog/watchdog.conf.epp', {
          'period'     => $period,
          'tickle'     => $tickle,
          'interfaces' => $watchdog::interfaces,
          'pings'      => $watchdog::pings,
        }),
      }
    }
    'OpenBSD': {
      if $watchdog::service_manage {
        sysctl { 'kern.watchdog.period':
          ensure => absent,
        }
        sysctl { 'kern.watchdog.auto':
          ensure => present,
          value  => 0,
        }
      } else {
        sysctl { 'kern.watchdog.period':
          ensure => present,
          value  => $period,
        }
        sysctl { 'kern.watchdog.auto':
          ensure => present,
          value  => 1,
        }
      }
    }
    default: {
      # noop
    }
  }
}
