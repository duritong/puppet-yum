#
# yum module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License version 3 as published by
# the Free Software Foundation.
#
class yum(
  $centos_testing_include_pkgs = hiera('yum_centos_testing_include_pkgs',''),
  $centos_testing_exclude_pkgs = hiera('yum_centos_testing_exclude_pkgs','')
) {
# autoupdate
  package {
    'yum-cron' :
      ensure => present
  }
  service {
    'yum-cron' :
      enable => true,
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      require => Package[yum-cron],
  }
  case $::operatingsystem {
    centos : {
      include yum::centos::base
      case $::lsbmajdistrelease {
        5 : {
          include yum::centos::five
        }
      }
    }
    default : {
      fail("no managed repo yet for this distro")
    }
  }
  if hiera('use_munin',false) {
    include ::yum::munin
  }
}
