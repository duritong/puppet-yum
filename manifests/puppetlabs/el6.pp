class yum::puppetlabs::el6 {
  yum::managed_yumrepo {
    'puppetlabs-products' :
      descr => 'Puppet Labs Products El 6 - $basearch',
      baseurl => 'http://yum.puppetlabs.com/el/6/products/$basearch',
      gpgcheck => 1,
      gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      enabled => 1;

    'puppetlabs-deps' :
      descr => 'Puppet Labs Dependencies El 6 - $basearch',
      baseurl => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
      gpgcheck => 1,
      gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      enabled => 1;
  }
}
