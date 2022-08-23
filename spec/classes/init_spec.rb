require 'spec_helper'
describe 'tempo' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('tempo') }
        it { is_expected.to contain_class('tempo::install').that_comes_before('Class[tempo::Config]') }
        it { is_expected.to contain_class('tempo::config').that_notifies('Class[tempo::Service]') }
        it { is_expected.to contain_class('tempo::service') }
        it { is_expected.to contain_group('tempo') }
        it { is_expected.to contain_file('/usr/local/bin/tempo') }
        it { is_expected.to contain_service('tempo') }
        it { is_expected.to contain_user('tempo') }
      end
    end
  end
end
