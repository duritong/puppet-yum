# yum::centos::puppetlabs class
#
# manage the puppetlabs centos repos
#
# === Parameters
#
# $repos:: {} - override options
#
class yum::centos::puppetlabs(
  $repos = {},
){
  $default_repos = {
    'puppetlabs-products' => {
      descr         => 'Puppetlabs products',
      baseurl       => 'http://yum.puppetlabs.com/el/$releasever/products/$basearch/',
      enabled       => 0,
      gpgcheck      => 1,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppetlabs',
      gpgkeyid      => '4BD6EC30',
      priority      => 1,
    },
    'puppetlabs-dependencies' => {
      descr         => 'Puppetlabs dependencies',
      baseurl       => 'http://yum.puppetlabs.com/el/$releasever/dependencies/$basearch/',
      enabled       => 1,
      gpgcheck      => 1,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      manage_gpgkey => false,
      priority      => 1,
    },
    'puppetlabs-devel' => {
      descr         => 'Puppetlabs devel deps',
      baseurl       => 'http://yum.puppetlabs.com/el/$releasever/devel/$basearch/',
      enabled       => 0,
      gpgcheck      => 1,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
      manage_gpgkey => false,
      priority      => 1,
    },
  }
  create_resources('yum::repo',resources_deep_merge($default_repos,$repos))
}
