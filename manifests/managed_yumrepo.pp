define yum::managed_yumrepo (
  $descr          = 'absent',
  $baseurl        = 'absent',
  $mirrorlist     = 'absent',
  $enabled        = 0,
  $gpgcheck       = 0,
  $gpgkey         = 'absent',
  $failovermethod = 'absent',
  $priority       = 99,
  $exclude        = 'absent',
  $includepkgs    = 'absent'
) {

  # ensure that everything is setup
  Anchor['yum::prerequisites::done'] -> file{
    "/etc/yum.repos.d/${name}.repo":
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
      enabled         => $enabled,
      gpgcheck        => $gpgcheck,
      gpgkey          => $gpgkey,
      failovermethod  => $failovermethod,
      priority        => $priority,
      exclude         => $exclude,
      includepkgs     => $includepkgs;
  }
}
