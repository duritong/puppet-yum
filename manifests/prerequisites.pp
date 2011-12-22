class yum::prerequisites {
  package {
    'yum-priorities' :
      ensure => present,
  }

  # ensure there are no other repos
  file {
    'yum_repos_d' :
      path => '/etc/yum.repos.d/',
      ensure => directory,
      recurse => true,
      purge => true,
      force => true,
      require => Package[yum-priorities],
      mode => 0755,
      owner => root,
      group => 0 ;

    'rpm_gpg' :
      path => '/etc/pki/rpm-gpg/',
      source => [
        "puppet:///modules/yum/rpm-gpg/${operatingsystem}.${lsbmajdistrelease}/",
        "puppet:///modules/yum/rpm-gpg/default/"
      ],
      sourceselect => all,
      recurse => true,
      purge => true,
      force => true,
      owner => root,
      group => 0,
      mode => '600' ;
  }
}
