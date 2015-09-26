# centos rolling repo
class yum::centos::cr {
  yum::repo{'CentOS-CR':
    descr    => 'CentOS-$releasever - CR',
    baseurl  => 'http://mirror.centos.org/centos/$releasever/cr/$basearch/',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    priority => 1,
  }
  if versioncmp($::operatingsystemmajrelease,'7') < 0 {
    package{'centos-release-cr':
      ensure  => installed,
      require => Yum::Repo['extras'],
      before  => Yum::Repo['CentOS-CR'],
    }
  }
}
