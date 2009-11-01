# manifests/yum.pp

class yum::munin {
  file{'/var/lib/munin/yum_updates.py':
    source => "puppet://$server/modules/yum/munin/yum_updates.py",
    require => Package['munin-node'],
    notify => Exec['yum_munin_updates_init'],
    owner => root, group => 0, mode => 0755;
  }
  exec{'yum_munin_updates_init':
    command => '/var/lib/munin/yum_updates.py',
    refreshonly => true,
  }
  file{'/etc/cron.daily/munin_yum_updates.sh':
    ensure => absent,
  }
  file{'/etc/cron.daily/z_munin_yum_updates.sh':
    source => "puppet://$server/modules/yum/munin/munin_yum_updates.sh",
    require => File['/var/lib/munin/yum_updates.py'],
    owner => root, group => 0, mode => 0755;
  }
  ::munin::plugin::deploy{'yum_updates':
    source => 'yum/munin/yum_updates',
  }
}
