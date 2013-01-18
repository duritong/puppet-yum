class yum::amazon::centos {
    yum::managed_yumrepo{
        'centos-base':
          descr => 'CentOS-6 - Base',
          mirrorlist => 'http://mirrorlist.centos.org/?release=6&arch=$basearch&repo=os',
          enabled => 0,
          gpgcheck => 1,
          gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
          priority => 50;
        'centos-updates':
          descr => 'CentOS-6 - Updates',
          mirrorlist => 'http://mirrorlist.centos.org/?release=6&arch=$basearch&repo=updates',
          enabled => 0,
          gpgcheck => 1,
          gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
          priority => 50;
        'centos-extras':
          descr => 'CentOS-6 - Extras',
          mirrorlist => 'http://mirrorlist.centos.org/?release=6&arch=$basearch&repo=extras',
          enabled => 0,
          gpgcheck => 1,
          gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
          priority => 50;
    }
}