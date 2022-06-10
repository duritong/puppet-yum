# yum::repo define
#
# Fully manages a yum repo
#
define yum::repo (
  $ensure           = 'present',
  $descr            = 'absent',
  $baseurl          = 'absent',
  $mirrorlist       = 'absent',
  Variant[Enum['absent'],Stdlib::HTTPSUrl]
  $metalink         = 'absent',
  $metadata_expire  = 300,
  $enabled          = 0,
  $gpgcheck         = 0,
  $repo_gpgcheck    = 0,
  $gpgkey           = 'absent',
  $gpgkeyid         = undef,
  $manage_gpgkey    = true,
  $gpgkey_source    = undef,
  $failovermethod   = 'absent',
  $priority         = 99,
  $protect          = 'absent',
  $timeout          = 10,
  $exclude          = 'absent',
  $includepkgs      = 'absent',
  $target           = "/etc/yum.repos.d/${name}.repo",
) {

  # otherwise we clean up things automatically
  if $ensure == 'present' {
    # ensure that everything is setup
    Anchor<| title == 'yum::prerequisites::done' |> -> file{
      $target:
        ensure  => file,
        replace => false,
        owner   => root,
        group   => 0,
        mode    => '0644';
    } -> yumrepo{
      $name:
        descr           => $descr,
        baseurl         => $baseurl,
        mirrorlist      => $mirrorlist,
        metalink        => $metalink,
        metadata_expire => $metadata_expire,
        enabled         => $enabled,
        gpgcheck        => $gpgcheck,
        repo_gpgcheck   => $repo_gpgcheck,
        gpgkey          => $gpgkey,
        failovermethod  => $failovermethod,
        protect         => $protect,
        priority        => $priority,
        timeout         => $timeout,
        exclude         => $exclude,
        includepkgs     => $includepkgs,
        target          => $target,
    }
    if ($gpgkey != 'absent') and ($gpgkey =~ /^file:\//) and $manage_gpgkey {
      $gpg_key_file = basename($gpgkey)
      if !defined(File["/etc/pki/rpm-gpg/${gpg_key_file}"]){
        file{"/etc/pki/rpm-gpg/${gpg_key_file}":
          ensure => file,
          owner  => root,
          group  => 0,
          mode   => '0644',
        } ~> exec{"rpm --import /etc/pki/rpm-gpg/${gpg_key_file}":
          refreshonly => true,
          before      => Yumrepo[$name],
        }

        if $manage_gpgkey {
          $real_gpgkey_source = $gpgkey_source ? {
            undef => [
              "puppet:///modules/yum/rpm-gpg/${::operatingsystem}.${::operatingsystemmajrelease}/${gpg_key_file}",
              "puppet:///modules/yum/rpm-gpg/${::operatingsystem}/${gpg_key_file}",
              "puppet:///modules/yum/rpm-gpg/default/${gpg_key_file}",
            ],
            default => $gpgkey_source,
          }
          File["/etc/pki/rpm-gpg/${gpg_key_file}"]{
            source        => $real_gpgkey_source
          }
        }

        if $gpgkeyid and !defined(Rpmkey[$gpgkeyid]) {
          rpmkey{$gpgkeyid:
            ensure  => 'present',
            source  => "/etc/pki/rpm-gpg/${gpg_key_file}",
            require => File["/etc/pki/rpm-gpg/${gpg_key_file}"],
            before  => Exec["rpm --import /etc/pki/rpm-gpg/${gpg_key_file}"],
          }
        }
      }
    }
    if $repo_gpgcheck == 1 and $enabled == 1 {
      if versioncmp($facts['os']['release']['major'],'8') < 0 {
        $makecache_cmd = "yum -q makecache fast -y --disablerepo='*' --enablerepo=${name}"
        $deletecache_cmd = "rm -rf /var/lib/yum/repos/${facts['os']['architecture']}/${facts['os']['release']['major']}/${name}"
        $test_cmd = "test -f /var/lib/yum/repos/${facts['os']['architecture']}/${facts['os']['release']['major']}/${name}/gpgdir-ro/pubring.gpg"
      } else {
        $makecache_cmd = "dnf -q makecache -y --disablerepo='*' --enablerepo=${name}"
        $deletecache_cmd = "rm -rf /var/cache/dnf/${name}-*/pubring"
        $test_cmd = "find /var/cache/dnf/ -maxdepth 2 -type d -regex '.*/${name}-[a-z0-9]*/pubring' | grep -q pubring"
      }
      exec{"import_yumrepo_gpgkey_${name}":
        command => $makecache_cmd,
        unless  => $test_cmd,
        require => Yumrepo[$name],
      }
      if ($gpgkey != 'absent') and ($gpgkey =~ /^file:\//) and $manage_gpgkey {
        exec{
          "clean-gpg-cache-${name}":
            command     => $deletecache_cmd,
            refreshonly => true,
            subscribe   => Exec["rpm --import /etc/pki/rpm-gpg/${gpg_key_file}"],
        } -> Exec["import_yumrepo_gpgkey_${name}"]
      }
    }
  }
}
