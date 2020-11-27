# Class to manage example parameters.
#
# Dont include this class directly.
#
class example::params {
  $archive_source  = undef
  $group           = 'example'
  $install_dir     = '/opt/example'
  $install_method  = 'package'
  $manage_service  = true
  $manage_user     = true
  $manage_repo     = true
  $package_name    = 'example'
  $package_version = 'present'
  $service_name    = 'example'
  $service_ensure  = 'running'
  $user            = 'example'
  case $::osfamily {
    'Debian': {
      case $::operatingsystemrelease {
        /(^7.*|^14\.04.*)/ : {
          $service_provider = 'debian'
        }
        default : {
          $service_provider = 'systemd'
        }
      }
    }
    'RedHat': {
      case $::operatingsystemrelease {
        /^6.*/ : {
          $service_provider = 'redhat'
        }
        default : {
          $service_provider = 'systemd'
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat")
    }
  }
}