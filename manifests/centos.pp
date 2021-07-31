# Install the basic repositories
class yum::centos {
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    $epel_suffix = "-${facts['os']['release']['major']}"
    $repos = {
      'base' => {
        descr          => 'CentOS-$releasever - Base',
        mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
        enabled        => 1,
        gpgcheck       => 1,
        repo_gpgcheck  => 1,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${facts['os']['release']['major']}",
        manage_gpgkey  => false,
        priority       => 1,
      },
      'debuginfo' => {
        descr          => 'CentOS-$releasever - DebugInfo',
        mirrorlist     => 'http://debuginfo.centos.org/$releasever/$basearch/',
        enabled        => 0,
        gpgcheck       => 1,
        repo_gpgcheck  => 0,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${facts['os']['release']['major']}",
        manage_gpgkey  => true,
        priority       => 1,
      },
      'updates' => {
        descr          => 'CentOS-$releasever - Updates',
        mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
        enabled        => 1,
        gpgcheck       => 1,
        repo_gpgcheck  => 1,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${facts['os']['release']['major']}",
        manage_gpgkey  => false,
        priority       => 1,
      },
      'extras' => {
        descr          => 'CentOS-$releasever - Extras',
        mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
        enabled        => 1,
        gpgcheck       => 1,
        repo_gpgcheck  => 1,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${facts['os']['release']['major']}",
        manage_gpgkey  => false,
        priority       => 1,
      },
      'centosplus' => {
        descr          => 'CentOS-$releasever - Centosplus',
        mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
        enabled        => 1,
        gpgcheck       => 1,
        repo_gpgcheck  => 1,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${facts['os']['release']['major']}",
        manage_gpgkey  => false,
        priority       => 2,
      },
      "rpmforge-rhel${facts['os']['release']['major']}" => {
        descr          => 'RPMForge RHEL5 packages',
        baseurl        => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
        enabled        => 1,
        gpgcheck       => 1,
        gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
        priority       => 30,
      },
      "centos${facts['os']['release']['major']}-plus"   => {
        descr          => 'CentOS-$releasever - Plus',
        mirrorlist     => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
        enabled        => 1,
        gpgcheck       => 1,
        repo_gpgcheck  => 1,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${facts['os']['release']['major']}",
        priority       => 15,
      },
      'epel'           => {
        descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch',
        metalink       => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-7&arch=$basearch&infra=$infra&content=$contentdir',
        enabled        => 1,
        gpgcheck       => 1,
        failovermethod => 'priority',
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL${epel_suffix}",
        priority       => 16,
      },
      'epel-debuginfo' => {
        descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
        metalink       => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-debug-7&arch=$basearch&infra=$infra&content=$contentdir',
        enabled        => 0,
        gpgcheck       => 1,
        failovermethod => 'priority',
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL${epel_suffix}",
        priority       => 16,
      },
      'epel-source' => {
        descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
        metalink       => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-source-7&arch=$basearch&infra=$infra&content=$contentdir',
        enabled        => 0,
        gpgcheck       => 1,
        failovermethod => 'priority',
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL${epel_suffix}",
        priority       => 16,
      },
      'epel-testing'   => {
        descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
        metalink       => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-epel7&arch=$basearch&infra=$infra&content=$contentdir',
        enabled        => 0,
        gpgcheck       => 1,
        failovermethod => 'priority',
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL${epel_suffix}",
        priority       => 16,
      },
      'epel-testing-debuginfo' => {
        descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
        metalink       => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-debug-epel7&arch=$basearch&infra=$infra&content=$contentdir',
        enabled        => 0,
        gpgcheck       => 1,
        failovermethod => 'priority',
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL${epel_suffix}",
        priority       => 16,
      },
      'epel-testing-source' => {
        descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
        metalink       => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-source-epel7&arch=$basearch&infra=$infra&content=$contentdir',
        enabled        => 0,
        gpgcheck       => 1,
        failovermethod => priority,
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL${epel_suffix}",
        priority       => 16,
      },
      'elrepo' => {
        descr      => 'ELRepo.org Community Enterprise Linux Repository - el$releasever',
        baseurl    => 'http://elrepo.org/linux/elrepo/el$relesever/$basearch/',
        mirrorlist => 'http://elrepo.org/mirrors-elrepo.el$releasever',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
        priority   => 20,
      },
      'elrepo-testing' => {
        descr      => 'ELRepo.org Community Enterprise Linux Testing Repository - el$releasever',
        baseurl    => 'http://elrepo.org/linux/testing/el$releasever/$basearch/',
        mirrorlist => 'http://elrepo.org/mirrors-elrepo-testing.el$releasever',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
        priority   => 20,
      },

      'elrepo-kernel' => {
        descr      => 'ELRepo.org Community Enterprise Linux Kernel Repository - el$releasever',
        baseurl    => 'http://elrepo.org/linux/kernel/el$releasever/$basearch/',
        mirrorlist => 'http://elrepo.org/mirrors-elrepo-kernel.el$releasever',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
        priority   => 20,
      },

      'elrepo-extras' => {
        descr      => 'ELRepo.org Community Enterprise Linux Repository - el$releasever',
        baseurl    => 'http://elrepo.org/linux/extras/el$releasever/$basearch/',
        mirrorlist => 'http://elrepo.org/mirrors-elrepo-extras.el$releasever',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org',
        priority   => 20,
      },
      'nux-dextop' => {
        descr    => 'Nux.Ro RPMs for general desktop use',
        baseurl  => 'http://li.nux.ro/download/nux/dextop/el$releasever/$basearch/ http://mirror.li.nux.ro/li.nux.ro/nux/dextop/el$releasever/$basearch/',
        enabled  => 1,
        gpgcheck => 1,
        gpgkeyid => '85C6CD8A',
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
  } else {
    $repos = {
      'AppStream'                      => {
        descr         => 'CentOS-$releasever - AppStream',
        mirrorlist    => 'http://mirrorlist.centos.org/?release=$stream&arch=$basearch&repo=AppStream&infra=$infra',
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        enabled       => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
        priority      => 1,
      },
      'BaseOS'                         => {
        descr         => 'CentOS-$releasever - Base',
        mirrorlist    => 'http://mirrorlist.centos.org/?release=$stream&arch=$basearch&repo=BaseOS&infra=$infra',
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        enabled       => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
        priority      => 1,
      },
      'base-debuginfo'                 => {
        descr         => 'CentOS-$releasever - Debuginfo',
        baseurl       => 'http://debuginfo.centos.org/$stream/$basearch/',
        gpgcheck      => 1,
        repo_gpgcheck => 0,
        enabled       => 0,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
        priority      => 1,
      },
      'extras'                         => {
        descr         => 'CentOS-$releasever - Extras',
        mirrorlist    => 'http://mirrorlist.centos.org/?release=$stream&arch=$basearch&repo=extras&infra=$infra',
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        enabled       => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
        priority      => 1,
      },
      'HighAvailability'               => {
        descr         => 'CentOS-$releasever - HA',
        mirrorlist    => 'http://mirrorlist.centos.org/?release=$stream&arch=$basearch&repo=extras&infra=$infra',
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        enabled       => 0,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
        priority      => 1,
      },
      'PowerTools'                     => {
        descr         => 'CentOS-$releasever - PowerTools',
        mirrorlist    => 'http://mirrorlist.centos.org/?release=$stream&arch=$basearch&repo=PowerTools&infra=$infra',
        gpgcheck      => 1,
        repo_gpgcheck => 1,
        enabled       => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
        priority      => 1,
      },
      'epel-modular'                   => {
        descr    => 'Extra Packages for Enterprise Linux Modular $releasever - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-modular-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        priority => 16,
      },
      'epel-modular-debuginfo'         => {
        descr    => 'Extra Packages for Enterprise Linux Modular $releasever - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-modular-debug-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-modular-source'            => {
        descr    => 'Extra Packages for Enterprise Linux Modular $releasever - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-modular-source-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-playground'                => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Playground - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=playground-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        priority => 16,
      },
      'epel-playground-debuginfo'      => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Playground - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=playground-debug-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-playground-source'         => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Playground - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=playground-source-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel'                           => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        priority => 16,
      },
      'epel-debuginfo'                 => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-debug-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-source'                    => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=epel-source-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-testing-modular'           => {
        descr    => 'Extra Packages for Enterprise Linux Modular $releasever - Testing - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-modular-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        priority => 16,
      },
      'epel-testing-modular-debuginfo' => {
        descr    => 'Extra Packages for Enterprise Linux Modular $releasever - Testing - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-modular-debug-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-testing-modular-source'    => {
        descr    => 'Extra Packages for Enterprise Linux Modular $releasever - Testing - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-modular-source-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-testing'                   => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        priority => 16,
      },
      'epel-testing-debuginfo'         => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-debug-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-testing-source'            => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?protocol=https&repo=testing-source-epel$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-next' => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Next - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-next-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-next-debuginfo' => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Next - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-next-debug-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-next-source' => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Next - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-next-source-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-next-testing' => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Next - Testing - $basearch',
        metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-testing-next-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-next-testing-debuginfo' => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Next - Testing - $basearch - Debug',
        metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-testing-next-debug-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'epel-next-testing-source' => {
        descr    => 'Extra Packages for Enterprise Linux $releasever - Next - Testing - $basearch - Source',
        metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-testing-next-source-$releasever&arch=$basearch&infra=$infra&content=$contentdir',
        enabled  => 0,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8',
        gpgcheck => 1,
        priority => 16,
      },
      'rpmfusion-free-updates' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-8&arch=$basearch',
        enabled    => 1,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-8',
        priority   => 30,
      },
      'rpmfusion-free-updates-debuginfo' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Debug',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-debug-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-8',
        priority   => 30,
      },
      'rpmfusion-free-updates-source' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Source',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-source-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-8',
        priority   => 30,
      },
      'rpmfusion-free-updates-testing' => {
        descr      => 'RPM Fusion for EL 8 - Free - Test Updates',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-8',
        priority   => 30,
      },
      'rpmfusion-free-updates-debuginfo' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Debug',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-debug-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-8',
        priority   => 30,
      },
      'rpmfusion-free-updates-source' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Source',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-source-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-8',
        priority   => 30,
      },
      'rpmfusion-nonfree-updates' => {
        descr      => 'RPM Fusion for EL 8 - Nonree - Updates',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-released-8&arch=$basearch',
        enabled    => 1,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-8',
        priority   => 30,
      },
      'rpmfusion-nonfree-updates-debuginfo' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Debug',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-released-debug-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-8',
        priority   => 30,
      },
      'rpmfusion-nonfree-updates-source' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Source',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-released-source-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-8',
        priority   => 30,
      },
      'rpmfusion-nonfree-updates-testing' => {
        descr      => 'RPM Fusion for EL 8 - Free - Test Updates',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-testing-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-8',
        priority   => 30,
      },
      'rpmfusion-nonfree-updates-debuginfo' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Debug',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-testing-debug-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-8',
        priority   => 30,
      },
      'rpmfusion-nonfree-updates-source' => {
        descr      => 'RPM Fusion for EL 8 - Free - Updates Source',
        mirrorlist => 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-testing-source-8&arch=$basearch',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-8',
        priority   => 30,
      },
    }
    package { [
      'epel-release',
      'epel-next-release',
      'rpmfusion-free-release',
      'rpmfusion-nonfree-release',]:
      ensure  => installed,
      require => Yum::Repo['epel','rpmfusion-free-updates','rpmfusion-nonfree-updates'],
    }
  }
}
