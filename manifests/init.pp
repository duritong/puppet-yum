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
  Boolean $manage_munin = false,
  Boolean $autoupdate   = true,
  String $repo_stage    = 'main',
) {
  class{[ 'yum::centos',
          'yum::prerequisites' ]:
    stage => $repo_stage,
  }
  $repos = $yum::centos::repos
  class{'yum::repos':
    repos => $repos,
    stage => $repo_stage,
  }
  if $manage_munin {
    include yum::munin
  }
  if $autoupdate {
    include yum::autoupdate
  }
  include yum::centos::disable_rhsmcertd
}
