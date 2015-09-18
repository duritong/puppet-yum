# yum::repo define
#
# Fully manages a yum repo
#
define yum::repo (
  $ensure           = 'present',
  $descr            = 'absent',
  $baseurl          = 'absent',
  $mirrorlist       = 'absent',
  $metadata_expire  = 300,
  $enabled          = 0,
  $gpgcheck         = 0,
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
    Anchor['yum::prerequisites::done'] -> file{
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
        metadata_expire => $metadata_expire,
        enabled         => $enabled,
        gpgcheck        => $gpgcheck,
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
          before => Yumrepo[$name],
        }

        if $manage_gpgkey {
          $real_gpgkey_source = $gpgkey_source ? {
            undef => [
              "puppet:///modules/yum/rpm-gpg/${::operatingsystem}.${::operatingsystemmajrelease}/${gpg_key_file}",
              "puppet:///modules/yum/rpm-gpg/${::operatingsystem}/${gpg_key_file}",
              "puppet:///modules/yum/rpm-gpg/default/${gpg_key_file}"
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
            before  => Yumrepo[$name],
          }
        }
      }
    }
  }
}
