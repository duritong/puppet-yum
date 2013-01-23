class yum::amazon::base {
    yum::managed_yumrepo{
      'amzn-main':
        descr => 'amzn-main-Base',
        mirrorlist => 'http://repo.eu-west-1.amazonaws.com/$releasever/main/mirror.list',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        priority => 1,
        failovermethod => 'priority';
      'amzn-updates':
        descr => 'amzn-updates-Base',
        mirrorlist => 'http://repo.eu-west-1.amazonaws.com/$releasever/updates/mirror.list',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        priority => 1,
        failovermethod => 'priority';
      'amzn-nosrc':
        descr => 'amzn-nosrc-Base',
        mirrorlist => 'http://repo.eu-west-1.amazonaws.com/$releasever/nosrc/mirror.list',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        priority => 1,
        failovermethod => 'priority';
      'amzn-preview':
        descr => 'amzn-preview-Base',
        mirrorlist => 'http://repo.eu-west-1.amazonaws.com/$releasever/preview/mirror.list',
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        priority => 1,
        failovermethod => 'priority';
      'epel':
        descr => 'Extra Packages for Enterprise Linux 6 - $basearch',
        mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 5,
        failovermethod => 'priority';
      'rpmforge':
        descr => 'RHEL $releasever - RPMforge.net - dag',
        baseurl => 'http://apt.sw.be/redhat/el6/en/$basearch/rpmforge',
        mirrorlist => 'http://apt.sw.be/redhat/el6/en/mirrors-rpmforge',
        enabled => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
        gpgcheck => 1;
      'rpmforge-extras':
        descr => 'RHEL $releasever - RPMforge.net - extras',
        baseurl => 'http://apt.sw.be/redhat/el6/en/$basearch/extras',
        mirrorlist => 'http://apt.sw.be/redhat/el6/en/mirrors-rpmforge-extras',
        enabled => 0,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
        gpgcheck => 1;
    }
}
