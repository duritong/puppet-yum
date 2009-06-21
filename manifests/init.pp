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

class yum {
    # autoupdate
    package { yum-cron:
        ensure => present
    }

    service { yum-cron:
        enable => true,
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package[yum-cron],
    }

    case $operatingsystem {
        centos: {
            case $lsbdistrelease {
                5: { include yum::centos::five }
                default: {
                    info("no class for this version yet defined, try to configure it with the version for 5")
                    include yum::centos::five
                }
            }
        }
        default: { fail("no managed repo yet for this distro") }
    }
    if $use_munin {
        include ::yum::munin
    }
}
