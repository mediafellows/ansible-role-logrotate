require 'spec_helper'

describe "Logrotate setup" do
  package('logrotate') do
    it { should be_installed }
  end

  describe file('/etc/logrotate.d/') do
    it { should be_directory }
  end

  global_max_size = ANSIBLE_VARS.fetch('logrotate_max_size', 'FAIL')

  ANSIBLE_VARS.fetch('logrotate_file_list', []).each do |file|
    describe file("/etc/logrotate.d/#{file['name']}") do
      it { should be_file }
      its(:content) { should include(file['path']) }
      its(:content) { should include("size #{ file.fetch('max_size', global_max_size) }") }
    end
  end
end
