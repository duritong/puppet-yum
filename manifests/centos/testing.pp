class yum::centos::testing {
    yum::managed_yumrepo{'centos5-testing':
        descr => 'CentOS-$releasever - Testing',
        baseurl => 'http://dev.centos.org/centos/$releasever/testing/$basearch',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing',
        priority => 1,
    }
    if $yum_centos_testing_include_pkgs {
        Yum::Managed_yumrepo['centos5-testing']{
          includepkgs => $yum_centos_testing_include_pkgs
        }
    } else {
      fail('Please configure $yum_centos_testing_include_pkgs as we run the testing repo with highest repository')
    }
}
