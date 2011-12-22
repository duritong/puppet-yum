class yum::centos::five {
  yum::managed_yumrepo {
    'addons' :
      descr => 'CentOS-$releasever - Addons',
      mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons',
      enabled => 1,
      gpgcheck => 1,
      gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever',
      priority => 1 ;
  }

  # sometimes yum-cron does not clean up things properly on EL5,
  # so we enforce some cleanup here
  tidy {
    "/var/lock" :
      age => "2d",
      recurse => 1,
      matches => ["yum-cron.lock"],
      rmdirs => true,
      type => ctime,
  }
}
