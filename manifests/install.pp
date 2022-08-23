# @summary A short summary of the purpose of this class
#
# @api private
class tempo::install {
  case $tempo::install_method {
    'archive': {
      $release_file_name = "tempo_${tempo::version}_linux_amd64"
      $version_dir = "${tempo::data_dir}/tempo-${tempo::version}"

      $binary_path = "${version_dir}/${release_file_name}"

      if $tempo::manage_user {
        user { 'tempo':
          ensure => present,
          home   => $tempo::data_dir,
          name   => $tempo::user,
        }
        group { 'tempo':
          ensure => present,
          name   => $tempo::group,
        }

        File[$version_dir] {
          require => [Group['tempo'],User['tempo']],
        }
      }

      file { [$tempo::data_dir, $version_dir]:
        ensure => directory,
        group  => $tempo::group,
        owner  => $tempo::user,
      }
      -> archive { "${binary_path}.tar.gz":
        ensure       => present,
        source       => "https://github.com/grafana/tempo/releases/download/v${tempo::version}/${release_file_name}.tar.gz",
        extract      => true,
        extract_path => $version_dir,
        creates      => "${version_dir}/tempo",
        cleanup      => false,
        user         => $tempo::user,
        group        => $tempo::group,
      }

      file {
        "${version_dir}/tempo":
          ensure  => file,
          group   => $tempo::group,
          mode    => '0755',
          owner   => $tempo::user,
          require => Archive["${binary_path}.tar.gz"],
          ;
        "${tempo::bin_dir}/tempo":
          ensure  => link,
          group   => $tempo::group,
          owner   => $tempo::user,
          target  => "${version_dir}/tempo",
          require => File["${version_dir}/tempo"],
          ;
      }

      if $tempo::manage_service {
        File["${tempo::bin_dir}/tempo"] {
          notify => Service['tempo'],
        }
      }
    }
    'package': {
      package { 'tempo':
        ensure => $tempo::package_version,
        name   => $tempo::package_name,
      }
    }
    default: {
      fail("Installation method ${tempo::install_method} not supported")
    }
  }
}
