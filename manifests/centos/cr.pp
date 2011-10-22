class yum::centos::cr {
  package{'centos-release-cr':
    ensure => installed,
  }
  yum::managed_yumrepo{'CentOS-CR':
    descr => 'CentOS-$releasever - CR',
    baseurl => 'http://mirror.centos.org/centos/$releasever/cr/$basearch/',
    enabled => 1,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${lsbmajdistrelease}",
    priority => 1,
    require => Package['centos-release-cr'],
  }
}
