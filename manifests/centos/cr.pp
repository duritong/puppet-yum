class yum::centos::cr {
  package{'centos-release-cr':
    ensure => present,
  }

  file{'/etc/yum.repos.d/CentOS-CR.repo':
    ensure => present,
    require => Package['centos-release-cr'],
  }
}
