require 'spec_helper'
describe 'example' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with archive_source set to special.tar.gz' do
        let(:params) do
          {
            archive_source: 'special.tar.gz',
            install_method: 'archive',
          }
        end

        it { is_expected.to contain_archive('example archive').with_source('special.tar.gz') }
      end

      context 'with group set to myspecialgroup' do
        let(:params) do
          {
            group: 'myspecialgroup',
            manage_user: true,
          }
        end

        it { is_expected.to contain_group('example').with_name('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and install_method set to archive' do
        let(:params) do
          {
            group: 'myspecialgroup',
            install_dir: '/opt/example',
            install_method: 'archive',
            manage_user: true,
          }
        end

        it { is_expected.to contain_file('example install dir').with_group('myspecialgroup') }
        it { is_expected.to contain_archive('example archive').with_group('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and install_method set to archive and manage_user set to true' do
        let(:params) do
          {
            group: 'myspecialgroup',
            install_dir: '/opt/example',
            install_method: 'archive',
            manage_user: true,
          }
        end

        it { is_expected.to contain_file('example install dir').with_group('myspecialgroup').that_requires('Group[myspecialgroup]') }
        it { is_expected.to contain_archive('example archive').with_group('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and install_method set to archive and manage_user set to false' do
        let(:params) do
          {
            group: 'myspecialgroup',
            install_dir: '/opt/example',
            install_method: 'archive',
            manage_user: false,
          }
        end

        it { is_expected.to contain_file('example install dir').with_group('myspecialgroup').that_requires(nil) }
        it { is_expected.to contain_archive('example archive').with_group('myspecialgroup') }
      end

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

      context 'with install_dir set to /opt/special' do
        let(:params) do
          {
            install_dir: '/opt/special',
            install_method: 'archive',
          }
        end

        it { is_expected.to contain_file('example install dir').with_path('/opt/special') }
        it { is_expected.to contain_archive('example archive').with_creates('/opt/special/bin') }
        it { is_expected.to contain_archive('example archive').with_extract_path('/opt/special') }
        it { is_expected.to contain_archive('example archive').that_requires('File[/opt/special]') }
      end

      context 'with install_dir set to /opt/special and manage_user set to true' do
        let(:params) do
          {
            install_dir: '/opt/special',
            install_method: 'archive',
            manage_user: true,
            user: 'example',
          }
        end

        it { is_expected.to contain_user('example').with_home('/opt/special') }
        it { is_expected.to contain_file('example install dir').with_path('/opt/special').that_requires('User[example]') }
      end

      context 'with install_method set to archive' do
        let(:params) do
          {
            install_dir: '/opt/example',
            install_method: 'archive',
            package_name: 'example',
          }
        end

        it { is_expected.to contain_file('example install dir').that_comes_before('Archive[example archive]') }
        it { is_expected.to contain_archive('example archive') }
        it { is_expected.not_to contain_package('example') }
      end

      context 'with install_method set to package' do
        let(:params) do
          {
            install_dir: '/opt/example',
            install_method: 'package',
            package_name: 'example',
          }
        end

        it { is_expected.not_to contain_file('example install dir').that_comes_before('Archive[example archive]') }
        it { is_expected.not_to contain_archive('example archive') }
        it { is_expected.to contain_package('example') }
      end

      context 'with manage_user set to true' do
        let(:params) do
          {
            group: 'example',
            manage_user: true,
            user: 'example',
          }
        end

        it { is_expected.to contain_user('example') }
        it { is_expected.to contain_group('example') }
      end

      context 'with manage_user set to false' do
        let(:params) do
          {
            manage_user: false,
          }
        end

        it { is_expected.not_to contain_user('example') }
        it { is_expected.not_to contain_group('example') }
      end

      context 'with package_name set to specialpackage' do
        let(:params) do
          {
            install_method: 'package',
            package_name: 'specialpackage',
          }
        end

        it { is_expected.to contain_package('example').with_name('specialpackage') }
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

      context 'with package_version set to 42.42.42' do
        let(:params) do
          {
            install_method: 'package',
            package_name: 'example',
            package_version: '42.42.42',
          }
        end

        it { is_expected.to contain_package('example').with_ensure('42.42.42') }
      end

      context 'with user set to myspecialuser' do
        let(:params) do
          {
            manage_user: true,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_user('example').with_name('myspecialuser') }
      end

      context 'with user set to myspecialuser and install_method set to archive' do
        let(:params) do
          {
            install_dir: '/opt/example',
            install_method: 'archive',
            manage_user: true,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_file('example install dir').with_owner('myspecialuser') }
        it { is_expected.to contain_archive('example archive').with_user('myspecialuser') }
      end

      context 'with user set to myspecialuser and install_method set to archive and manage_user set to true' do
        let(:params) do
          {
            install_dir: '/opt/example',
            install_method: 'archive',
            manage_user: true,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_file('example install dir').with_owner('myspecialuser').that_requires('User[myspecialuser]') }
        it { is_expected.to contain_archive('example archive').with_user('myspecialuser') }
      end

      context 'with user set to myspecialuser and install_method set to archive and manage_user set to false' do
        let(:params) do
          {
            install_dir: '/opt/example',
            install_method: 'archive',
            manage_user: false,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_file('example install dir').with_owner('myspecialuser').that_requires(nil) }
        it { is_expected.to contain_archive('example archive').with_user('myspecialuser') }
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
    end
  end
end
