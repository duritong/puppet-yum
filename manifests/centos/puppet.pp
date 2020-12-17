# yum::centos::puppet class
#
# manage the puppet centos repos
#
# === Parameters
#
# $repos:: {} - override options
#
class yum::centos::puppet (
  $repos = {},
) {
  file { '/etc/pki/rpm-gpg/GPG-KEY-puppet-20210817':
    source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppet-release-20210817',
  } -> exec { 'validate gpg key':
      command   => 'gpg --keyid-format 0xLONG /etc/pki/rpm-gpg/GPG-KEY-puppet-20210817 | grep -q 6F6B15509CF8E59E6E469F327F438280EF8D349F',
      logoutput => 'on_failure',
  } -> exec { 'import gpg key':
      command   => 'rpm --import /etc/pki/rpm-gpg/GPG-KEY-puppet-20210817',
      unless    => 'rpm -q gpg-pubkey-`echo $(gpg --throw-keyids < /etc/pki/rpm-gpg/GPG-KEY-puppet-20210817) | cut --characters=11-18 | tr [A-Z] [a-z]`',
      logoutput => 'on_failure',
  } -> package { 'puppet-release':
    ensure => 'installed',
  }
  $release = $facts['os']['release']['major']
  $default_repos = {
    'puppet'        => {
      descr         => "Puppet Repository el ${release} - \$basearch",
      baseurl       => "https://yum.puppetlabs.com/puppet/el/${release}/\$basearch",
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release',
      gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-puppet-release',
      gpgkeyid      => '9E61EF26',
      enabled       => 1,
      gpgcheck      => 1,
      priority      => 1,
    },
    'puppet-source' => {
      descr         => "Puppet Repository el ${release} - Source",
      baseurl       => "https://yum.puppetlabs.com/puppet/el/${release}/SRPMS",
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release',
      manage_gpgkey => false,
      enabled       => 0,
      gpgcheck      => 1,
      priority      => 1,
    },
  }
  $all_repos = deep_merge($default_repos,$repos)
  $all_repos.each |$repo,$params| {
    yum::repo {
      $repo:
        * => $params,
    }
  }
}
