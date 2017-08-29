# yum::centos::puppet class
#
# manage the puppet centos repos
#
# === Parameters
#
# $repos:: {} - override options
#
class yum::centos::puppet(
  $repos = {},
){
  if versioncmp($puppetversion,'4.0') >= 0 {
    package{'puppet-release':
      ensure => 'installed',
    }
    $release = $facts['os']['release']['major']
    $default_repos = {
      'puppet'        => {
        descr         => "Puppet Repository el ${release} - $basearch",
        baseurl       => "http://yum.puppetlabs.com/puppet/el/${release}/\$basearch",
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet',
        gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppet',
        gpgkeyid      => 'EF8D349F',
        enabled       => 1,
        gpgcheck      => 1,
        priority      => 1,
      },
      'puppet-source' => {
        descr         => "Puppet Repository el ${release} - Source",
        baseurl       => "http://yum.puppetlabs.com/puppet/el/${release}/SRPMS",
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet',
        manage_gpgkey => false,
        enabled       => 0,
        gpgcheck      => 1,
        priority      => 1,
      },
    }
  } else {
    $default_repos = {
      'puppet' => {
        descr         => 'Puppet products',
        baseurl       => 'http://yum.puppet.com/el/$releasever/products/$basearch/',
        enabled       => 1,
        gpgcheck      => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet',
        gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppet',
        gpgkeyid      => 'EF8D349F',
        priority      => 1,
      },
      'puppet-dependencies' => {
        descr         => 'Puppetlabs dependencies',
        baseurl       => 'http://yum.puppet.com/el/$releasever/dependencies/$basearch/',
        enabled       => 1,
        gpgcheck      => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet',
        manage_gpgkey => false,
        priority      => 1,
      },
      'puppet-devel' => {
        descr         => 'Puppetlabs devel deps',
        baseurl       => 'http://yum.puppet.com/el/$releasever/devel/$basearch/',
        enabled       => 0,
        gpgcheck      => 1,
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet',
        manage_gpgkey => false,
        priority      => 1,
      },
    }
  }
  create_resources('yum::repo',resources_deep_merge($default_repos,$repos))
}
