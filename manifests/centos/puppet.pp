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
  package{'puppet-release':
    ensure => 'installed',
  }
  $release = $facts['os']['release']['major']
  $default_repos = {
    'puppet'        => {
      descr         => "Puppet Repository el ${release} - \$basearch",
      baseurl       => "http://yum.puppetlabs.com/puppet/el/${release}/\$basearch",
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release',
      gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppet-release',
      gpgkeyid      => 'EF8D349F',
      enabled       => 1,
      gpgcheck      => 1,
      priority      => 1,
    },
    'puppet-source' => {
      descr         => "Puppet Repository el ${release} - Source",
      baseurl       => "http://yum.puppetlabs.com/puppet/el/${release}/SRPMS",
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release',
      manage_gpgkey => false,
      enabled       => 0,
      gpgcheck      => 1,
      priority      => 1,
    },
  }
  $all_repos = deep_merge($default_repos,$repos)
  $all_repos.each |$repo,$params| {
    yum::repo{
      $repo:
        * => $params,
    }
  }
}
