# manage munin module for yum
class yum::munin {
  if  versioncmp($facts['os']['release']['major'],'8') < 0 {
    file{
      default:
        require => Package['munin-node'],
        owner   => root;
      '/var/lib/munin/plugin-state/yum':
        ensure => directory,
        group  => 'nobody',
        mode   => '0640';
      '/var/lib/munin/yum_updates.py':
        source  => 'puppet:///modules/yum/munin/yum_updates.py',
        group   => 0,
        mode    => '0750';
    } ~> exec{'yum_munin_updates_init':
      command     => '/var/lib/munin/yum_updates.py',
      refreshonly => true,
    } -> file{'/etc/cron.daily/z_munin_yum_updates.sh':
      source  => 'puppet:///modules/yum/munin/munin_yum_updates.sh',
      require => File['/var/lib/munin/yum_updates.py'],
      owner   => root,
      group   => 0,
      mode    => '0755';
    } -> munin::plugin::deploy{'yum_updates':
      source => 'yum/munin/yum_updates',
    }
  } else {
    file{
      '/var/lib/munin/plugin-state/dnf':
        ensure => directory,
        owner  => 'root',
        group  => 'nobody',
        mode   => '0640',
    } -> munin::plugin::deploy{'dnf':
      source => 'yum/munin/dnf',
      config => 'group nobody'
    } -> systemd::timer{
      'update-munin-dnf.timer':
        timer_source   => 'puppet:///modules/yum/munin/dnf.timer',
        service_source => 'puppet:///modules/yum/munin/dnf.service',
        active         => true,
        enable         => true,
    }
  }
}
