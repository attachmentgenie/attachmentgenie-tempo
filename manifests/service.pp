# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tempo::service
class tempo::service {
  if $::tempo::manage_service {
    case $::tempo::service_provider {
      'systemd': {
        ::systemd::unit_file { "${::tempo::service_name}.service":
          content => epp('tempo/tempo.service.epp'),
          before  => Service['tempo'],
        }
      }
      default: {
        fail("Service provider ${::tempo::service_provider} not supported")
      }
    }

    case $::tempo::install_method {
      'archive': {}
      'package': {
        Service['tempo'] {
          subscribe => Package['tempo'],
        }
      }
      default: {
        fail("Installation method ${::tempo::install_method} not supported")
      }
    }

    service { 'tempo':
      ensure   => $::tempo::service_ensure,
      enable   => true,
      name     => $::tempo::service_name,
      provider => $::tempo::service_provider,
    }
  }
}
