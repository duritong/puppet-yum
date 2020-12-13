# autoupdate class
#
# manage and enable autoupdate
#
# === Parameters
#
# $apply_updates::   yes|no - should updates be applied
# $update_messages:: no|yes - should you be informed about updates
#
class yum::autoupdate (
  Enum['yes','no'] $apply_updates   = 'yes',
  Enum['yes','no'] $update_messages = 'no',
) {
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    # autoupdate
    package {
      'yum-cron' :
        ensure => present,
    } -> service {
      'yum-cron' :
        ensure => running,
        enable => true,
    }

    file_line {
      'enable_autoupdate':
        line    => "apply_updates = ${apply_updates}",
        match   => '^apply_updates',
        path    => '/etc/yum/yum-cron.conf',
        require => Package['yum-cron'],
        notify  => Service['yum-cron'];
      'silence_update':
        line    => "update_messages = ${update_messages}",
        match   => '^update_messages',
        path    => '/etc/yum/yum-cron.conf',
        require => Package['yum-cron'],
        notify  => Service['yum-cron'];
    }
  } else {
    package {
      'dnf-automatic':
        ensure => installed,
    } -> file_line {
      'enable_autoupdate':
        line  => "apply_updates = ${apply_updates}",
        match => '^apply_updates',
        path  => '/etc/dnf/automatic.conf',
    } ~> service {
      'dnf-automatic.timer':
        enable => true,
        status => running,
    }
  }
}
