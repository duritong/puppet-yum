# centos rolling repo
class yum::centos::cr {
  # there is no CR from streams
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
  }
}
