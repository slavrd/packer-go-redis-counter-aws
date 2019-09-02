control 'webcounter_check' do

  describe systemd_service('webcounter.service') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe http('http://127.0.0.1:8000/health') do
    its('status') { should eq 500 }
  end

  describe http('http://127.0.0.1:8000/metrics') do
    its('status') { should eq 200 }
  end

end
