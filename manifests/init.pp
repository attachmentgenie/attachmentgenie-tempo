# Class to install and configure example.
#
# Use this module to install and configure example.
#
# @example Declaring the class
#   include ::example
#
# @param archive_source Location of example binary release.
# @param group Group that owns example files.
# @param install_dir Location of example binary release.
# @param install_method How to install example.
# @param manage_repo Manage the example repo.
# @param manage_service Manage the example service.
# @param manage_user Manage example user and group.
# @param package_name Name of package to install.
# @param package_version Version of example to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param user User that owns example files.
class example (
  Optional[String] $archive_source = $::example::params::archive_source,
  String $group = $::example::params::group,
  String $install_dir = $::example::params::install_dir,
  Enum['archive','package'] $install_method = $::example::params::install_method,
  Boolean $manage_repo = $::example::params::manage_repo,
  Boolean $manage_service = $::example::params::manage_service,
  Boolean $manage_user = $::example::params::manage_user,
  String $package_name = $::example::params::package_name,
  String $package_version = $::example::params::package_version,
  String $service_name = $::example::params::service_name,
  String $service_provider = $::example::params::service_provider,
  Enum['running','stopped'] $service_ensure = $::example::params::service_ensure,
  String $user = $::example::params::user,
) inherits example::params {
  anchor { 'example::begin': }
  -> class{ '::example::install': }
  -> class{ '::example::config': }
  ~> class{ '::example::service': }
  -> anchor { 'example::end': }
}
