# prerequisits for our yum setup
class yum::prerequisites {
  package {
    'yum-priorities' :
      ensure => present,
  }
  case $::operatingsystem {
    amazon : {
      Package['yum-priorities']{
        name => 'yum-plugin-priorities'
      }
    }
    default : {
      if $::operatingsystemmajrelease > 5 {
        Package['yum-priorities']{
          name => 'yum-plugin-priorities'
        }
        if $::operatingsystemmajrelease < 7 {
          package{'yum-presto':
            ensure => present,
          }
        } else {
          package{'deltarpm':
            ensure => present,
          }
        }
      }
    }
  }

  # ensure there are no other repos
  file {
    'yum_repos_d' :
      ensure        => directory,
      path          => '/etc/yum.repos.d/',
      recurse       => true,
      purge         => true,
      force         => true,
      require       => Package[yum-priorities],
      before        => Anchor['yum::prerequisites::done'],
      owner         => root,
      group         => 0,
      mode          => '0755';

    'rpm_gpg' :
      path          => '/etc/pki/rpm-gpg/',
      source        => [
        "puppet:///modules/yum/rpm-gpg/${::operatingsystem}.${::operatingsystemmajrelease}/",
        "puppet:///modules/yum/rpm-gpg/${::operatingsystem}/",
        'puppet:///modules/yum/rpm-gpg/default/'
      ],
      sourceselect  => all,
      require       => Package[yum-priorities],
      before        => Anchor['yum::prerequisites::done'],
      recurse       => true,
      purge         => true,
      force         => true,
      owner         => root,
      group         => 0,
      mode          => '0600';
  }

  anchor{'yum::prerequisites::done': }
}
