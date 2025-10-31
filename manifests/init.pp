# Class to install and configure tempo.
#
# Use this module to install and configure tempo.
#
# @example Declaring the class
#   include ::tempo
#
# @param bin_dir Location of tempo binary release.
# @param config_dir Location of tempo config files.
# @param data_dir Location of tempo data directories.
# @param group Group that owns tempo files.
# @param install_method How to install tempo.
# @param manage_service Manage the tempo service.
# @param manage_unit_file Manage the tempo service definition file.
# @param manage_user Manage tempo user and group.
# @param multitenancy_enabled Enable multi tenancy
# @param multitenancy_key Key name
# @param package_name Name of package to install.
# @param package_version Version of tempo to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param user User that owns tempo files.
# @param version Version of tempo to install.
# @param compactor_config_hash Compactor config hash.
# @param distributor_config_hash Distributor config hash.
# @param ingester_config_hash Ingestor config hash.
# @param memberlist_config_hash Memberlist config hash.
# @param server_config_hash Server config hash.
# @param storage_config_hash Storage config hash.
# @param query_frontend_config_hash Query Frontend config hash.
# @param querier_config_hash Querier config hash.
class tempo (
  Stdlib::Absolutepath $bin_dir,
  Stdlib::Absolutepath $config_dir,
  Stdlib::Absolutepath $data_dir,
  String[1] $group,
  Enum['archive','package'] $install_method ,
  Boolean $manage_service,
  Boolean $manage_unit_file = $install_method ? { 'archive' => true, 'package' => false },
  Boolean $manage_user = $install_method ? { 'archive' => true, 'package' => false },
  Boolean $multitenancy_enabled,
  String[1] $multitenancy_key,
  String[1] $package_name,
  String[1] $package_version,
  String[1] $service_name,
  String[1] $service_provider,
  Enum['running','stopped'] $service_ensure,
  String[1] $user,
  String[1] $version,
  Optional[Hash] $compactor_config_hash = undef,
  Optional[Hash] $distributor_config_hash = undef,
  Optional[Hash] $ingester_config_hash = undef,
  Optional[Hash] $memberlist_config_hash = undef,
  Optional[Hash] $server_config_hash = undef,
  Optional[Hash] $storage_config_hash = undef,
  Optional[Hash] $query_frontend_config_hash = undef,
  Optional[Hash] $querier_config_hash = undef,
) {
  contain 'tempo::install'
  contain 'tempo::config'
  contain 'tempo::service'

  Class['tempo::install']
  -> Class['tempo::config']
  ~> Class['tempo::service']
}
