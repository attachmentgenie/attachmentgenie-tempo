require 'spec_helper'
describe 'example' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with group set to myspecialgroup and service_provider set to debian' do
        let(:params) do
          {
            group: 'myspecialgroup',
            install_dir: '/opt/example',
            manage_service: true,
            manage_user: true,
            service_name: 'example',
            service_provider: 'debian',
          }
        end

        it { is_expected.to contain_file('example service file').with_group('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and service_provider set to init' do
        let(:params) do
          {
            group: 'myspecialgroup',
            install_dir: '/opt/example',
            manage_service: true,
            manage_user: true,
            service_name: 'example',
            service_provider: 'init',
          }
        end

        it { is_expected.to contain_file('example service file').with_group('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and service_provider set to redhat' do
        let(:params) do
          {
            group: 'myspecialgroup',
            install_dir: '/opt/example',
            manage_service: true,
            manage_user: true,
            service_name: 'example',
            service_provider: 'redhat',
          }
        end

        it { is_expected.to contain_file('example service file').with_group('myspecialgroup') }
      end

      context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to debian' do
        let(:params) do
          {
            install_dir: '/opt/special',
            manage_service: true,
            service_name: 'example',
            service_provider: 'debian',
          }
        end

        it { is_expected.to contain_file('example service file').with_content(%r{^exec="\/opt\/special\/example"$}) }
      end

      context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to init' do
        let(:params) do
          {
            install_dir: '/opt/special',
            manage_service: true,
            service_name: 'example',
            service_provider: 'init',
          }
        end

        it { is_expected.to contain_file('example service file').with_content(%r{^exec="\/opt\/special\/example"$}) }
      end

      context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to redhat' do
        let(:params) do
          {
            install_dir: '/opt/special',
            manage_service: true,
            service_name: 'example',
            service_provider: 'redhat',
          }
        end

        it { is_expected.to contain_file('example service file').with_content(%r{^exec="\/opt\/special\/example"$}) }
      end

      context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to systemd' do
        let(:params) do
          {
            install_dir: '/opt/special',
            manage_service: true,
            service_name: 'example',
            service_provider: 'systemd',
          }
        end

        it { is_expected.to contain_systemd__Unit_file('example.service').with_content(%r{^ExecStart=/opt/special/example}) }
      end

      context 'with manage_service set to true' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'example',
          }
        end

        it { is_expected.to contain_service('example') }
      end

      context 'with manage_service set to false' do
        let(:params) do
          {
            manage_service: false,
            service_name: 'example',
          }
        end

        it { is_expected.not_to contain_service('example') }
      end

      context 'with package_name set to specialpackage and manage_service set to true' do
        let(:params) do
          {
            install_method: 'package',
            manage_service: true,
            package_name: 'specialpackage',
            service_name: 'example',
          }
        end

        it { is_expected.to contain_package('example').with_name('specialpackage') }
      end

      context 'with service_name set to specialservice' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
          }
        end

        it { is_expected.to contain_service('example').with_name('specialservice') }
      end

      context 'with service_name set to specialservice and with service_provider set to debian' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
            service_provider: 'debian',
          }
        end

        it { is_expected.to contain_service('example').with_name('specialservice') }
        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/specialservice').that_notifies('Service[example]').with_content(%r{^prog="specialservice"}) }
      end

      context 'with service_name set to specialservice and with service_provider set to init' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
            service_provider: 'init',
          }
        end

        it { is_expected.to contain_service('example').with_name('specialservice') }
        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/specialservice').that_notifies('Service[example]').with_content(%r{^prog="specialservice"}) }
      end

      context 'with service_name set to specialservice and with service_provider set to redhat' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
            service_provider: 'redhat',
          }
        end

        it { is_expected.to contain_service('example').with_name('specialservice') }
        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/specialservice').that_notifies('Service[example]').with_content(%r{^prog="specialservice"}) }
      end

      context 'with service_name set to specialservice and with service_provider set to systemd' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
            service_provider: 'systemd',
          }
        end

        it { is_expected.to contain_service('example').with_name('specialservice') }
        it { is_expected.to contain_systemd__Unit_file('specialservice.service').that_comes_before('Service[example]').with_content(%r{^Description=specialservice}) }
      end

      context 'with service_name set to specialservice and with install_method set to package' do
        let(:params) do
          {
            install_method: 'package',
            manage_service: true,
            package_name: 'example',
            service_name: 'specialservice',
          }
        end

        it { is_expected.to contain_service('example').with_name('specialservice').that_subscribes_to('Package[example]') }
      end

      context 'with service_provider set to init' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'example',
            service_provider: 'init',
          }
        end

        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/example') }
        it { is_expected.not_to contain_systemd__Unit_file('example.service').that_comes_before('Service[example]') }
        it { is_expected.to contain_service('example') }
      end

      context 'with service_provider set to systemd' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'example',
            service_provider: 'systemd',
          }
        end

        it { is_expected.not_to contain_file('example service file').with_path('/etc/init.d/example') }
        it { is_expected.to contain_systemd__Unit_file('example.service').that_comes_before('Service[example]') }
        it { is_expected.to contain_service('example') }
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

      context 'with user set to myspecialuser and service_provider set to debian' do
        let(:params) do
          {
            user: 'myspecialuser',
            install_dir: '/opt/example',
            manage_user: true,
            manage_service: true,
            service_name: 'example',
            service_provider: 'debian',
          }
        end

        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/example').with_owner('myspecialuser') }
      end

      context 'with user set to myspecialuser and service_provider set to init' do
        let(:params) do
          {
            user: 'myspecialuser',
            install_dir: '/opt/example',
            manage_user: true,
            manage_service: true,
            service_name: 'example',
            service_provider: 'init',
          }
        end

        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/example').with_owner('myspecialuser') }
      end

      context 'with user set to myspecialuser and service_provider set to redhat' do
        let(:params) do
          {
            user: 'myspecialuser',
            install_dir: '/opt/example',
            manage_user: true,
            manage_service: true,
            service_name: 'example',
            service_provider: 'redhat',
          }
        end

        it { is_expected.to contain_file('example service file').with_path('/etc/init.d/example').with_owner('myspecialuser') }
      end
    end
  end
end
