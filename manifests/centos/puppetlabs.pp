# the puppetlabs centos repos
class yum::centos::puppetlabs(
  $enable_products      = 1,
  $enable_dependencies  = 1,
  $enable_devel         = 0,
){

  file{'/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs':
    source  => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppetlabs',
    owner   => root,
    group   => 0,
    mode    => '0600';
  } -> rpmkey{'4BD6EC30':
    ensure => 'present',
    source => '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
  } -> yum::managed_yumrepo{
    'puppetlabs-products':
      descr          => 'Puppetlabs products',
      baseurl        => 'http://yum.puppetlabs.com/el/$releasever/products/$basearch/',
      enabled        => $enable_products,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      priority       => 1;
    'puppetlabs-dependencies':
      descr          => 'Puppetlabs dependencies',
      baseurl        => 'http://yum.puppetlabs.com/el/$releasever/dependencies/$basearch/',
      enabled        => $enable_dependencies,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      priority       => 1;
    'puppetlabs-devel':
      descr          => 'Puppetlabs devel deps',
      baseurl        => 'http://yum.puppetlabs.com/el/$releasever/devel/$basearch/',
      enabled        => $enable_devel,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      priority       => 1;
  }

}
