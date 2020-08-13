# yum::centos::remi class
#
# manage the remi centos repos
#
# === Parameters
#
# $repos:: {} - override options
#
class yum::centos::remi(
  $repos = {},
){
  if versioncmp($facts['os']['release']['major'],'7') >= 0 {
    $release = $facts['os']['release']['major']
    $default_repos = {
      'remi-safe'     => {
        descr         => "Safe Remi's RPM repository for Enterprise Linux ${release} - \$basearch",
        mirrorlist    => "http://cdn.remirepo.net/enterprise/${release}/safe/mirror",
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
        gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-remi',
        gpgkeyid      => '00F97F56',
        enabled       => 1,
        gpgcheck      => 1,
        priority      => 1,
      },
      'remi-safe-debuginfo' => {
        descr         => "Safe Remi's RPM repository for Enterprise Linux ${release} - \$basearch - debuginfo",
        baseurl       => "http://rpms.remirepo.net/enterprise/${release}/debug-remi/\$basearch/",
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
        gpgkey_source => 'puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-remi',
        manage_gpgkey => false,
        enabled       => 0,
        gpgcheck      => 1,
        priority      => 1,
      },
    }
  } else {
    fail('This repository is only supported from EL7 on')
  }
  extlib::resources_deep_merge($default_repos,$repos).each |$repo,$vals| {
    yum::repo{
      $repo:
        * => $vals,
    }
  }
}
