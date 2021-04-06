require 'spec_helper'

describe 'watchdog' do
  on_supported_os.each do |os, facts|
    context "on #{os}", :compile do
      let(:facts) do
        facts
      end
      let(:params) do
        {
          :interfaces => ['eth0'],
          :pings => ['192.168.0.1']
        }
      end

      it { is_expected.to contain_class('watchdog') }
      it { is_expected.to contain_class('watchdog::config') }
      it { is_expected.to contain_class('watchdog::install') }
      it { is_expected.to contain_class('watchdog::service') }

      case facts[:osfamily]
      when 'OpenBSD'
        it { is_expected.to contain_service('watchdogd').with_flags('-i 20 -p 60') }
        it { is_expected.to contain_sysctl('kern.watchdog.period').with_ensure('absent') }
        it {
          is_expected.to contain_sysctl('kern.watchdog.auto').with(
        'ensure' => 'present',
        'value'  => 0,
      )
        }
      when 'RedHat'
        it { is_expected.to contain_file('/etc/watchdog.conf')
          .with_content(/.*watchdog-timeout\s+=\s+60.*/)
          .with_content(/.*interval\s+=\s+20.*/)
          .with_content(/.*interface\s+=\s+eth0/)
          .with_content(/.*ping\s+=\s+192\.168\.0\.1/)
        }
        it { is_expected.to contain_package('watchdog') }
        it { is_expected.to contain_service('watchdog') }
      end
    end
  end
end
