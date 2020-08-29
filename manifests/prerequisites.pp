# prerequisits for our yum setup
class yum::prerequisites {
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    package {
      'yum-plugin-priorities':
        ensure => present,
    } -> File['/etc/pki/rpm-gpg','/etc/yum.repos.d']
    package{'deltarpm':
      ensure => present,
      before => Anchor['yum::prerequisites::done'],
    }
  }

  # ensure there are no other repos nor gpg keys
  file {
    default:
      owner => root,
      group => 0,
      mode  => '0644';
    '/etc/yum/pluginconf.d/subscription-manager.conf':
      content => "[main]
enabled=0
";
    ['/etc/pki/rpm-gpg','/etc/yum.repos.d']:
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
  } -> anchor{'yum::prerequisites::done': }
}
