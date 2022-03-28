# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'with default parameters ', if: ['debian', 'redhat', 'ubuntu'].include?(os[:family]) do
  pp = <<-PUPPETCODE
  class { '::tempo': }
PUPPETCODE

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe group('tempo') do
    it { is_expected.to exist }
  end

  describe user('tempo') do
    it { is_expected.to exist }
  end

  describe file('/etc/tempo') do
    it { is_expected.to be_directory }
  end

  describe file('/var/lib/tempo') do
    it { is_expected.to be_directory }
  end

  describe service('tempo') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running.under('systemd') }
  end

  describe port(3200) do
    it { is_expected.to be_listening }
  end
end
