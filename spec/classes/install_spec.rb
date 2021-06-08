require 'spec_helper'
describe 'tempo' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with group set to myspecialgroup' do
        let(:params) do
          {
            group: 'myspecialgroup',
            manage_user: true,
          }
        end

        it { is_expected.to contain_group('tempo').with_name('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and install_method set to archive' do
        let(:params) do
          {
            group: 'myspecialgroup',
            bin_dir: '/opt/tempo',
            install_method: 'archive',
            manage_user: true,
          }
        end

        it { is_expected.to contain_file('/opt/tempo/tempo').with_group('myspecialgroup') }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_group('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and install_method set to archive and manage_user set to true' do
        let(:params) do
          {
            group: 'myspecialgroup',
            bin_dir: '/opt/tempo',
            install_method: 'archive',
            manage_user: true,
          }
        end

        it { is_expected.to contain_file('/opt/tempo/tempo').with_group('myspecialgroup').that_requires('Group[myspecialgroup]') }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_group('myspecialgroup') }
      end

      context 'with group set to myspecialgroup and install_method set to archive and manage_user set to false' do
        let(:params) do
          {
            group: 'myspecialgroup',
            bin_dir: '/opt/tempo',
            install_method: 'archive',
            manage_user: false,
          }
        end

        it { is_expected.to contain_file('/opt/tempo/tempo').with_group('myspecialgroup').that_requires(nil) }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_group('myspecialgroup') }
      end

      context 'with bin_dir set to /opt/special' do
        let(:params) do
          {
            bin_dir: '/opt/special',
            install_method: 'archive',
          }
        end

        it { is_expected.to contain_file('/opt/special/tempo') }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_creates('/var/lib/tempo/tempo-1.0.0/tempo') }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_extract_path('/var/lib/tempo/tempo-1.0.0') }
      end

      context 'with data_dir set to /opt/special and manage_user set to true' do
        let(:params) do
          {
            data_dir: '/opt/special',
            install_method: 'archive',
            manage_user: true,
            user: 'tempo',
          }
        end

        it { is_expected.to contain_user('tempo').with_home('/opt/special') }
        it { is_expected.to contain_file('/opt/special') }
      end

      context 'with install_method set to archive' do
        let(:params) do
          {
            data_dir: '/opt/tempo',
            install_method: 'archive',
            package_name: 'tempo',
          }
        end

        it { is_expected.to contain_archive('/opt/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz') }
        it { is_expected.not_to contain_package('tempo') }
      end

      context 'with install_method set to package' do
        let(:params) do
          {
            bin_dir: '/opt/tempo',
            install_method: 'package',
            package_name: 'tempo',
          }
        end

        it { is_expected.not_to contain_file('/opt/tempo/tempo').that_comes_before('Archive[tempo archive]') }
        it { is_expected.not_to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz') }
        it { is_expected.to contain_package('tempo') }
      end

      context 'with manage_user set to true' do
        let(:params) do
          {
            group: 'tempo',
            manage_user: true,
            user: 'tempo',
          }
        end

        it { is_expected.to contain_user('tempo') }
        it { is_expected.to contain_group('tempo') }
      end

      context 'with manage_user set to false' do
        let(:params) do
          {
            manage_user: false,
          }
        end

        it { is_expected.not_to contain_user('tempo') }
        it { is_expected.not_to contain_group('tempo') }
      end

      context 'with package_name set to specialpackage' do
        let(:params) do
          {
            install_method: 'package',
            package_name: 'specialpackage',
          }
        end

        it { is_expected.to contain_package('tempo').with_name('specialpackage') }
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

      context 'with package_version set to 42.42.42' do
        let(:params) do
          {
            install_method: 'package',
            package_name: 'tempo',
            package_version: '42.42.42',
          }
        end

        it { is_expected.to contain_package('tempo').with_ensure('42.42.42') }
      end

      context 'with user set to myspecialuser' do
        let(:params) do
          {
            manage_user: true,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_user('tempo').with_name('myspecialuser') }
      end

      context 'with user set to myspecialuser and install_method set to archive' do
        let(:params) do
          {
            bin_dir: '/opt/tempo',
            install_method: 'archive',
            manage_user: true,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_file('/opt/tempo/tempo').with_owner('myspecialuser') }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_user('myspecialuser') }
      end

      context 'with user set to myspecialuser and install_method set to archive and manage_user set to true' do
        let(:params) do
          {
            bin_dir: '/opt/tempo',
            install_method: 'archive',
            manage_user: true,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_file('/opt/tempo/tempo').with_owner('myspecialuser').that_requires('User[myspecialuser]') }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_user('myspecialuser') }
      end

      context 'with user set to myspecialuser and install_method set to archive and manage_user set to false' do
        let(:params) do
          {
            bin_dir: '/opt/tempo',
            install_method: 'archive',
            manage_user: false,
            user: 'myspecialuser',
          }
        end

        it { is_expected.to contain_file('/opt/tempo/tempo').with_owner('myspecialuser').that_requires(nil) }
        it { is_expected.to contain_archive('/var/lib/tempo/tempo-1.0.0/tempo_1.0.0_linux_amd64.tar.gz').with_user('myspecialuser') }
      end
    end
  end
end
