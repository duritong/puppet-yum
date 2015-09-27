# Install the basic repositories
class yum::centos {
  $base_repos = {
    'base' => {
      descr          => 'CentOS-$releasever - Base',
      mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
      enabled        => 1,
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      manage_gpgkey  => false,
      priority       => 1,
    },
    'debuginfo' => {
      descr          => 'CentOS-$releasever - DebugInfo',
      mirrorlist     => 'http://debuginfo.centos.org/$releasever/$basearch/',
      enabled        => 0,
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      manage_gpgkey  => false,
      priority       => 1,
    },
    'updates' => {
      descr          => 'CentOS-$releasever - Updates',
      mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
      enabled        => 1,
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      manage_gpgkey  => false,
      priority       => 1,
    },
    'extras' => {
      descr          => 'CentOS-$releasever - Extras',
      mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
      enabled        => 1,
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      manage_gpgkey  => false,
      priority       => 1,
    },
    'centosplus' => {
      descr          => 'CentOS-$releasever - Centosplus',
      mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
      enabled        => 1,
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      manage_gpgkey  => false,
      priority       => 2,
    },
    'contrib' => {
      descr          => 'CentOS-$releasever - Contrib',
      mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      manage_gpgkey  => false,
      priority       => 10,
    },
    "rpmforge-rhel${::operatingsystemmajrelease}" => {
      descr          => 'RPMForge RHEL5 packages',
      baseurl        => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
      enabled        => 1,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
      priority       => 30,
    },
    "centos${::operatingsystemmajrelease}-plus"   => {
      descr          => 'CentOS-$releasever - Plus',
      mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
      enabled        => 1,
      gpgcheck       => 1,
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      priority       => 15,
    },
    'epel'           => {
      descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch',
      mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
      enabled        => 1,
      gpgcheck       => 1,
      failovermethod => 'priority',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      priority       => 16,
    },
    'epel-debuginfo' => {
      descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
      mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
      enabled        => 0,
      gpgcheck       => 1,
      failovermethod => 'priority',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      priority       => 16,
    },
    'epel-source'    => {
      descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
      mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
      enabled        => 0,
      gpgcheck       => 1,
      failovermethod => 'priority',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      priority       => 16,
    },
    'epel-testing'                                => {
      descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
      mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel$releasever&arch=$basearch',
      enabled        => 0,
      gpgcheck       => 1,
      failovermethod => 'priority',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      priority       => 17,
    },
    'epel-testing-debuginfo'                      => {
      descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
      mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel$releasever&arch=$basearch',
      enabled        => 0,
      gpgcheck       => 1,
      failovermethod => 'priority',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      priority       => 17,
    },
    'epel-testing-source'                         => {
      descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
      mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel$releasever&arch=$basearch',
      enabled        => 0,
      gpgcheck       => 1,
      failovermethod => priority,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      priority       => 17,
    },
    'elrepo'         => {
      descr          => 'ELRepo.org Community Enterprise Linux Repository - el$releasever',
      baseurl        => 'http://elrepo.org/linux/elrepo/el$relesever/$basearch/',
      mirrorlist     => 'http://elrepo.org/mirrors-elrepo.el$releasever',
      enabled        => 0,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
      priority       => 20,
    },
    'elrepo-testing' => {
      descr          => 'ELRepo.org Community Enterprise Linux Testing Repository - el$releasever',
      baseurl        => 'http://elrepo.org/linux/testing/el5/$basearch/',
      mirrorlist     => 'http://elrepo.org/mirrors-elrepo-testing.el$releasever',
      enabled        => 0,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
      priority       => 20,
    },

    'elrepo-kernel' => {
      descr         => 'ELRepo.org Community Enterprise Linux Kernel Repository - el$releasever',
      baseurl       => 'http://elrepo.org/linux/kernel/el$releasever/$basearch/',
      mirrorlist    => 'http://elrepo.org/mirrors-elrepo-kernel.el$releasever',
      enabled       => 0,
      gpgcheck      => 1,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
      priority      => 20,
    },

    'elrepo-extras' => {
      descr         => 'ELRepo.org Community Enterprise Linux Repository - el$releasever',
      baseurl       => 'http://elrepo.org/linux/extras/el$releasever/$basearch/',
      mirrorlist    => 'http://elrepo.org/mirrors-elrepo-extras.el$releasever',
      enabled       => 0,
      gpgcheck      => 1,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
      priority      => 20,
    },
  }

  if versioncmp($::operatingsystemmajrelease,'6') < 0 {
    $osversion_repos = {
      'addons' => {
        descr         => 'CentOS-$releasever - Addons',
        mirrorlist    => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons',
        enabled       => 1,
        gpgcheck      => 1,
        gpgkey        => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
        manage_gpgkey => false,
        priority      => 1 ,
      }
    }
    # sometimes yum-cron does not clean up things properly on EL5,
    # so we enforce some cleanup here
    tidy {
      '/var/lock':
        age     => '2d',
        recurse => 1,
        matches => ['yum-cron.lock'],
        rmdirs  => true,
        type    => ctime,
    }
  } else {
    $osversion_repos = {
      'nux-dextop' => {
        descr    => 'Nux.Ro RPMs for general desktop use',
        baseurl  => 'http://li.nux.ro/download/nux/dextop/el$releasever/$basearch/ http://mirror.li.nux.ro/li.nux.ro/nux/dextop/el$releasever/$basearch/',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-nux.ro',
        protect  => 0,
        priority => 30,
      },
      'nux-dextop-testing' => {
        descr    => 'Nux.Ro RPMs for general desktop use - testing',
        baseurl  => 'http://li.nux.ro/download/nux/dextop-testing/el$releasever/$basearch/',
        enabled  => 0,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-nux.ro',
        protect  => 0,
        priority => 30,
      },
    }
  }

  $repos = merge($base_repos,$osversion_repos)
}
