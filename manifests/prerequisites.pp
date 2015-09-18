# prerequisits for our yum setup
class yum::prerequisites {
  package {
    'yum-priorities' :
      ensure => present,
  }
  if versioncmp($::operatingsystemmajrelease,'5') > 0 {
    Package['yum-priorities']{
      name => 'yum-plugin-priorities'
    }
    package{'deltarpm':
      ensure => present,
      before => Anchor['yum::prerequisites::done'],
    }
    if versioncmp($::operatingsystemmajrelease,'7') < 0 {
      Package['deltarpm']{
        name => 'yum-presto'
      }
    }
  }

  # ensure there are no other repos nor gpg keys
  file {
    ['/etc/pki/rpm-gpg','/etc/yum.repos.d']:
      ensure        => directory,
      recurse       => true,
      purge         => true,
      force         => true,
      require       => Package['yum-priorities'],
      owner         => root,
      group         => 0,
      mode          => '0755';
  } -> anchor{'yum::prerequisites::done': }
}
