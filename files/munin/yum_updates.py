#!/usr/bin/env python
# Python helper script to query for the packages that have
# pending updates. Called by the yum package provider
#
# (C) 2007 Red Hat Inc.
# David Lutterkort <dlutter @redhat.com>
# Adapated for Munin plugin usage by Puzzle ITC
# Marcel Haerry <haerry(at)puzzle.ch>

import sys
import string
import re

# this maintains compatibility with really old platforms with python 1.x
from os import popen, WEXITSTATUS

# Try to use the yum libraries by default, but shell out to the yum executable
# if they are not present (i.e. yum <= 2.0). This is only required for RHEL3
# and earlier that do not support later versions of Yum. Once RHEL3 is EOL,
# shell_out() and related code can be removed.
try:
    import yum
except ImportError:
    useyumlib = 0
else:
    useyumlib = 1

OVERRIDE_OPTS = {
    'debuglevel': 0,
    'errorlevel': 0,
    'logfile': '/dev/null'
}

def pkg_count(my):
    my.doConfigSetup()

    for k in OVERRIDE_OPTS.keys():
        if hasattr(my.conf, k):
            setattr(my.conf, k, OVERRIDE_OPTS[k])
        else:
            my.conf.setConfigOption(k, OVERRIDE_OPTS[k])

    my.doTsSetup()
    my.doRpmDBSetup()

    # Yum 2.2/2.3 python libraries require a couple of extra function calls to setup package sacks.
    # They also don't have a __version__ attribute
    try:
	yumver = yum.__version__
    except AttributeError:
        my.doRepoSetup()
        my.doSackSetup()

    return len(my.doPackageLists('updates').updates)

def shell_out():
    count=0
    try:
        p = popen("/usr/bin/env yum check-update 2>&1")
        output = p.readlines()
        rc = p.close()

        if rc is not None:
            # None represents exit code of 0, otherwise the exit code is in the
            # format returned by wait(). Exit code of 100 from yum represents
            # updates available.
            if WEXITSTATUS(rc) != 100:
                return count
        else:
            # Exit code is None (0), no updates waiting so don't both parsing output
            return count 

        # Yum prints a line of hyphens (old versions) or a blank line between
        # headers and package data, so skip everything before them
        skipheaders = 0
        for line in output:
            if not skipheaders:
                if re.compile("^((-){80}|)$").search(line):
                    skipheaders = 1
                continue

            # Skip any blank lines
            if re.compile("^[ \t]*$").search(line):
                continue

            count = count + 1

        return count
    except:
        print sys.exc_info()[0]
        return count

if useyumlib:
    try:
        try:
            my = yum.YumBase()
            count = pkg_count(my)
        finally:
            my.closeRpmDB()
    except IOError, e:
        print "_err IOError %d %s" % (e.errno, e)
        sys.exit(1)
    except AttributeError, e:
        # catch yumlib errors in buggy 2.x versions of yum
        print "_err AttributeError %s" % e
        sys.exit(1)
else:
    count = shell_out()

f=open('/var/lib/munin-node/plugin-state/yum/update.state','w')
f.write(str(count))
f.close()
