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

# yum class
#
# === Parameters
#
# $manage_munin:: false|true - add munin plugin
# $autoupdate:: true|false - autoupdate?
# $repo_stage:: 'main'|... - stage on which repos should be managed
#
class yum(
  $manage_munin                = false,
  $autoupdate                  = true,
  $repo_stage                  = 'main',
) {
  validate_bool($manage_munin,$autoupdate)
  validate_string($repo_stage)
  case $::operatingsystem {
    'CentOS': {
      class{[ '::yum::centos',
              '::yum::prerequisites' ]:
        stage => $repo_stage,
      }
      include ::yum::centos
      $repos = $yum::centos::repos
    }
    default : {
      fail('no managed repo yet for this distro')
    }
  }
  class{'yum::repos':
    repos => $repos,
    stage => $repo_stage,
  }
  if $manage_munin {
    include ::yum::munin
  }
  if $autoupdate {
    include ::yum::autoupdate
  }
}
