# @summary A short summary of the purpose of this class
#
# @api private
class tempo::config {
  $config_file = "${tempo::config_dir}/config.yaml"

  file { $tempo::config_dir:
    ensure => directory,
  }
  -> concat { $config_file:
    ensure => present,
  }

  if $::tempo::manage_service {
    Concat[$config_file] {
      notify => Service['tempo'],
    }
  }

  concat::fragment { 'tempo_config_header':
    target  => $config_file,
    content => "---\n",
    order   => '01',
  }

  # Enables authentication through the X-Scope-OrgID header, which must be present
  # if true. If false, the OrgID will always be set to "fake".
  # [auth_enabled: <boolean> | default = true]
  $_auth_enabled = $tempo::auth_enabled ? {
    undef          => true,
    default        => $tempo::auth_enabled,
  }
  concat::fragment { 'tempo_config_auth_enabled':
    target  => $config_file,
    content => "auth_enabled: ${_auth_enabled}\n",
    order   => '03',
  }

  # Configures the server of the launched module(s).
  # [server: <server_config>]
  if $tempo::server_config_hash {
    concat::fragment { 'tempo_server_config':
      target  => $config_file,
      content => $tempo::server_config_hash.promtail::to_yaml.promtail::strip_yaml_header,
      order   => '10',
    }
  }

  # Configures the compactor and how the compactor will register itself to a
  # key value store.
  # [compactor: <compactor_config>]
  if $tempo::compactor_config_hash {
    concat::fragment { 'tempo_compactor_config':
      target  => $config_file,
      content => $tempo::compactor_config_hash.promtail::to_yaml.promtail::strip_yaml_header,
      order   => '11',
    }
  }

  # Configures the distributor.
  # [distributor: <distributor_config>]
  if $tempo::distributor_config_hash {
    concat::fragment { 'tempo_distributor_config':
      target  => $config_file,
      content => $tempo::distributor_config_hash.promtail::to_yaml.promtail::strip_yaml_header,
      order   => '12',
    }
  }

  # Configures the ingester and how the ingester will register itself to a
  # key value store.
  # [ingester: <ingester_config>]
  if $tempo::ingester_config_hash {
    concat::fragment { 'tempo_ingester_config':
      target  => $config_file,
      content => $tempo::ingester_config_hash.promtail::to_yaml.promtail::strip_yaml_header,
      order   => '13',
    }
  }

  # Configures the memberlist and how the memberlist will register itself to a
  # key value store.
  # [memberlist: <memberlist_config>]
  if $tempo::memberlist_config_hash {
    concat::fragment { 'tempo_memberlist_config':
      target  => $config_file,
      content => $tempo::memberlist_config_hash.promtail::to_yaml.promtail::strip_yaml_header,
      order   => '14',
    }
  }

  # Configures the storage and how the storage will register itself to a
  # key value store.
  # [storage: <storage_config>]
  if $tempo::storage_config_hash {
    concat::fragment { 'tempo_storage_config':
      target  => $config_file,
      content => $tempo::storage_config_hash.promtail::to_yaml.promtail::strip_yaml_header,
      order   => '15',
    }
  }
}