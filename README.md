# attachmentgenie-tempo

[![](https://img.shields.io/puppetforge/pdk-version/attachmentgenie/tempo.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/tempo)
[![](https://img.shields.io/puppetforge/v/attachmentgenie/tempo.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/tempo)
[![](https://img.shields.io/puppetforge/dt/attachmentgenie/tempo.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/tempo)
[![](https://travis-ci.org/attachmentgenie/attachmentgenie-tempo.svg?branch=master)](https://travis-ci.org/attachmentgenie/attachmentgenie-tempo)
[![License](https://img.shields.io/github/license/attachmentgenie/attachmentgenie-tempo?stype=popout)](https://github.com/attachmentgenie/attachmentgenie-tempo/blob/master/LICENSE)

Deploy and configure tempo on a node.

- [Description](#description)
- [Usage](#usage)
- [Reference](#reference)
- [Changelog](#changelog)
- [Limitations](#limitations)
- [Development](#development)

## Description

[Tempo](https://grafana.com/oss/tempo)

Grafana Tempo is an open source, easy-to-use and high-scale distributed tracing backend. Tempo is cost-efficient, requiring only object storage to operate, and is deeply integrated with Grafana, Prometheus, and Loki. Tempo can be used with any of the open source tracing protocols, including Jaeger, Zipkin, and OpenTelemetry.

## Usage

All options and configuration can be done through interacting with the parameters
on the main example class.
These are now documented via [Puppet Strings](https://github.com/puppetlabs/puppet-strings)

You can view example usage in [REFERENCE](REFERENCE.md).

## Reference

See [REFERENCE](REFERENCE.md).

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

### Running tests

This project contains tests for both rspec-puppet and litmus to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart:

```
pdk bundle install
pdk bundle exec rake 'litmus:provision_list[puppet6]'
pdk bundle exec rake 'litmus:install_agent[puppet6]'
pdk bundle exec rake litmus:install_module
pdk bundle exec rake litmus:acceptance:parallel
pdk bundle exec rake litmus:tear_down
