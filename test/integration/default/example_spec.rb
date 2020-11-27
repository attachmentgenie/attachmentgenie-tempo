control 'jobmanager 01' do
  impact 1.0
  title 'example jobmanager service is running'
  desc 'Ensures that the example jobmanager service is up and running'
  describe service('example') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_installed }
    it { is_expected.to be_running }
  end
end

control 'jobmanager 02' do
  impact 1.0
  title 'example jobmanager service is listening at port 8081'
  desc 'Ensures that the example jobmanager service is listening at port 8081'
  describe port(8081) do
    it { is_expected.to be_listening }
    its('processes') { is_expected.to include 'java' }
    its('protocols') { is_expected.to include 'tcp6' }
  end
end
