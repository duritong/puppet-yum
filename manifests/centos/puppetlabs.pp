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
    mode    => '600';
  } -> yum::managed_yumrepo{
    'puppetlabs-products':
      descr          => 'Puppetlabs products',
      baseurl        => 'http://yum.puppetlabs.com/el/$releaseverServer/products/$basearch/',
      enabled        => $enable_products,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      priority       => 50;
    'puppetlabs-dependencies':
      descr          => 'Puppetlabs dependencies',
      baseurl        => 'http://yum.puppetlabs.com/el/$releaseverServer/dependencies/$basearch/',
      enabled        => $enable_dependencies,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      priority       => 50;
    'puppetlabs-devel':
      descr          => 'Puppetlabs devel deps',
      baseurl        => 'http://yum.puppetlabs.com/el/$releaseverServer/devel/$basearch/',
      enabled        => $enable_devel,
      gpgcheck       => 1,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      priority       => 50;
  }

}
