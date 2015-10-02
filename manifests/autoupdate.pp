# autoupdate class
#
# manage and enable autoupdate
#
# === Parameters
#
# $apply_updates::   yes|no - should updates be applied
# $update_messages:: no|yes - should you be informed about updates
#
class yum::autoupdate(
  $apply_updates   = 'yes',
  $update_messages = 'no',
) {

  validate_re($apply_updates,['^yes$','^no$'])
  validate_re($update_messages,['^yes$','^no$'])

  # autoupdate
  package {
    'yum-cron' :
      ensure => present
  } -> service {
    'yum-cron' :
      ensure => running,
      enable => true,
  }

  if versioncmp($::operatingsystemmajrelease,'6') > 0 {
    file_line{
      'enable_autoupdate':
        line   => "apply_updates = ${apply_updates}",
        match  => '^apply_updates',
        path   => '/etc/yum/yum-cron.conf',
        notify => Service['yum-cron'];
      'silence_update':
        line   => "update_messages = ${update_messages}",
        match  => '^update_messages',
        path   => '/etc/yum/yum-cron.conf',
        notify => Service['yum-cron'];
    }
  }
}
