# disable rhsmcertd sneaking in over subscription manager
class yum::centos::disable_rhsmcertd {
  service{'rhsmcertd':
    ensure => stopped,
    enable => false,
  }
}
