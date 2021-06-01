# Installs and manages a watchdog.
#
# @example Declaring the class
#   include ::watchdog
#
# @param manage_package
# @param package_name The name of the package.
# @param period
# @param service_enable
# @param service_ensure
# @param service_manage Whether to manage the service.
# @param service_name Name of the service.
# @param interfaces Array of network interfaces to watch, empty by default.
# @param pings Array of network addresess to ping, empty by default.
class watchdog (
  Boolean                 $manage_package,
  Optional[String]        $package_name,
  Integer[0]              $period,
  Boolean                 $service_enable,
  Stdlib::Ensure::Service $service_ensure,
  Boolean                 $service_manage,
  String                  $service_name,
  Array[String]           $interfaces = [],
  Array[String]           $pings = [],
) {

  contain watchdog::install
  contain watchdog::config
  contain watchdog::service

  Class['watchdog::install'] -> Class['watchdog::config']
    ~> Class['watchdog::service']
}
