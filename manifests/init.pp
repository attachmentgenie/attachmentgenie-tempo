# Class to install and configure tempo.
#
# Use this module to install and configure tempo.
#
# @tempo Declaring the class
#   include ::tempo
#
# @param group Group that owns tempo files.
# @param bin_dir Location of tempo binary release.
# @param install_method How to install tempo.
# @param manage_repo Manage the tempo repo.
# @param manage_service Manage the tempo service.
# @param manage_user Manage tempo user and group.
# @param package_name Name of package to install.
# @param package_version Version of tempo to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param user User that owns tempo files.
class tempo (
  Stdlib::Absolutepath $bin_dir,
  Stdlib::Absolutepath $config_dir,
  Stdlib::Absolutepath $data_dir,
  String[1] $group,
  Enum['archive','package'] $install_method ,
  Boolean $manage_service,
  Boolean $manage_user,
  String[1] $package_name,
  String[1] $package_version,
  String[1] $service_name,
  String[1] $service_provider,
  Enum['running','stopped'] $service_ensure,
  String[1] $user,
  String[1] $version,
  Optional[Boolean] $auth_enabled = undef,
  Optional[Hash] $compactor_config_hash = undef,
  Optional[Hash] $distributor_config_hash = undef,
  Optional[Hash] $ingester_config_hash = undef,
  Optional[Hash] $memberlist_config_hash = undef,
  Optional[Hash] $server_config_hash = undef,
  Optional[Hash] $storage_config_hash = undef,
) {
  anchor { 'tempo::begin': }
  -> class{ '::tempo::install': }
  -> class{ '::tempo::config': }
  ~> class{ '::tempo::service': }
  -> anchor { 'tempo::end': }
}
