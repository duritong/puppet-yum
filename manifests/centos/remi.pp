# yum::centos::remi class
#
# manage the remi centos repos
#
# === Parameters
#
# $repos:: {} - override options
#
class yum::centos::remi (
  $repos = {},
) {
  $release = $facts['os']['release']['major']
  $mirrorlist = versioncmp($release, '8') ? {
    -1      => "http://cdn.remirepo.net/enterprise/${release}/safe/mirror",
    default => "http://cdn.remirepo.net/enterprise/${release}/safe/\$basearch/mirror"
  }
  $keyid = $release ? {
    '7' => '00F97F56',
    '8' => '555097595F11735A',
  }

  $default_repos = {
    'remi-safe'     => {
      descr         => "Safe Remi's RPM repository for Enterprise Linux ${release} - \$basearch",
      mirrorlist    => $mirrorlist,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
      gpgkey_source => "puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-remi.el${release}",
      enabled       => 1,
      gpgkeyid      => $keyid,
      gpgcheck      => 1,
      priority      => 1,
    },
    'remi-safe-debuginfo' => {
      descr         => "Safe Remi's RPM repository for Enterprise Linux ${release} - \$basearch - debuginfo",
      baseurl       => "http://rpms.remirepo.net/enterprise/${release}/debug-remi/\$basearch/",
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
      gpgkey_source => "puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-remi.el${release}",
      manage_gpgkey => false,
      enabled       => 0,
      gpgcheck      => 1,
      priority      => 1,
    },
  }
  deep_merge($default_repos,$repos).each |$repo,$vals| {
    yum::repo {
      $repo:
        * => $vals,
    }
  }
}
