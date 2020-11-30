require 'spec_helper'
describe 'tempo' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with manage_service set to true' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'tempo',
          }
        end

        it { is_expected.to contain_service('tempo') }
      end

      context 'with manage_service set to false' do
        let(:params) do
          {
            manage_service: false,
            service_name: 'tempo',
          }
        end

        it { is_expected.not_to contain_service('tempo') }
      end

      context 'with package_name set to specialpackage and manage_service set to true' do
        let(:params) do
          {
            install_method: 'package',
            manage_service: true,
            package_name: 'specialpackage',
            service_name: 'tempo',
          }
        end

        it { is_expected.to contain_package('tempo').with_name('specialpackage') }
      end

      context 'with service_name set to specialservice' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
          }
        end

        it { is_expected.to contain_service('tempo').with_name('specialservice') }
      end

      context 'with service_name set to specialservice and with service_provider set to systemd' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
            service_provider: 'systemd',
          }
        end

        it { is_expected.to contain_service('tempo').with_name('specialservice') }
        it { is_expected.to contain_systemd__Unit_file('specialservice.service').that_comes_before('Service[tempo]').with_content(%r{^Documentation=https://github.com/grafana/tempo}) }
      end

      context 'with service_name set to specialservice and with install_method set to package' do
        let(:params) do
          {
            install_method: 'package',
            manage_service: true,
            package_name: 'tempo',
            service_name: 'specialservice',
          }
        end

        it { is_expected.to contain_service('tempo').with_name('specialservice').that_subscribes_to('Package[tempo]') }
      end

      context 'with service_provider set to systemd' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'tempo',
            service_provider: 'systemd',
          }
        end

        it { is_expected.to contain_systemd__Unit_file('tempo.service').that_comes_before('Service[tempo]') }
        it { is_expected.to contain_service('tempo') }
      end

      context 'with service_provider set to invalid' do
        let(:params) do
          {
            manage_service: true,
            service_provider: 'invalid',
          }
        end

        it { is_expected.to raise_error(%r{Service provider invalid not supported}) }
      end
    end
  end
end
