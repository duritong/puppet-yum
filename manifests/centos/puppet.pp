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
    owner  => root,
    group  => root,
    mode   => '0644',
  } ~> exec { 'validate RPM-GPG-KEY-puppet-release-20210817':
      command     => 'gpg --keyid-format 0xLONG /etc/pki/rpm-gpg/GPG-KEY-puppet-20210817 | grep -q 0x7F438280EF8D349F',
      refreshonly => true,
      logoutput   => 'on_failure',
  } ~> exec { 'import RPM-GPG-KEY-puppet-release-20210817':
      command     => 'rpm --import /etc/pki/rpm-gpg/GPG-KEY-puppet-20210817',
      unless      => 'rpm -q gpg-pubkey-`echo $(gpg --throw-keyids < /etc/pki/rpm-gpg/GPG-KEY-puppet-20210817) | cut --characters=11-18 | tr [A-Z] [a-z]`',
      refreshonly => true,
      logoutput   => 'on_failure',
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
