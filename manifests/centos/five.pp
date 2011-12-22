class yum::centos::five {
    # sometimes yum-cron does not clean up things properly on EL5,
    # so we enforce some cleanup here
    tidy { "/var/lock":
      age => "2d",
      recurse => 1,
      matches => [ "yum-cron.lock" ],
      rmdirs => true,
      type => ctime,
    }
}
