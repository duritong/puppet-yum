# centos rolling repo
class yum::centos::cr {
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    yum::repo{'CentOS-CR':
      descr         => 'CentOS-$releasever - CR',
      baseurl       => 'http://mirror.centos.org/centos/$releasever/cr/$basearch/',
      enabled       => 1,
      gpgcheck      => 1,
      repo_gpgcheck => 1,
      gpgkey        => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      priority      => 1,
    }
  } else {
    yum::repo{'cr':
      descr         => 'CentOS-$releasever - cr',
      mirrorlist    => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=cr&infra=$infra',
      gpgcheck      => 1,
      repo_gpgcheck => 1,
      enabled       => 1,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
      priority      => 1,
    }
  }
}
