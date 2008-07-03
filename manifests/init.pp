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

#modules_dir { "yum": }

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
}

class yum::centos::five {
    yum::managed_yumrepo {base:
        descr => 'CentOS-$releasever - Base',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {updates:
        descr => 'CentOS-$releasever - Updates',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {addons:
        descr => 'CentOS-$releasever - Addons',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {extras:
        descr => 'CentOS-$releasever - Extras',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {centosplus:
        descr => 'CentOS-$releasever - Centosplus',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 2,
    }

    yum::managed_yumrepo {'rubyworks':
        descr => 'Rubyworks for better Ruby stuff',
        baseurl => 'http://rubyworks.rubyforge.org/redhat/$releasever/RPMS/$basearch',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RubyWorks.GPG.key', 
        priority => 1,
    }

    yum::managed_yumrepo {contrib:
        descr => 'CentOS-$releasever - Contrib',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 10,
    }


    yum::managed_yumrepo { dlutter-rhel5:
        descr => 'Unsupported RHEL5 packages (lutter)',
        baseurl => 'http://people.redhat.com/dlutter/yum/rhel/5/$basearch',
        enabled => 1,
        gpgcheck => 0,
        priority => 15,
    }

    yum::managed_yumrepo { dlutter-source:
        descr => 'Sources for additional test packages (lutter)',
        baseurl => 'http://people.redhat.com/dlutter/yum/SRPMS/',
        enabled => 1,
        gpgcheck => 0,
        priority => 15,
    }

    yum::managed_yumrepo { rpmforge-rhel5:
        descr => 'RPMForge RHEL5 packages',
        baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
	    priority => 30,
	}
	yum::managed_yumrepo {centos5-atrpms:
	    descr => 'CentOS $releasever - $basearch - ATrpms',
        baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
	    enabled => 1,
		gpgcheck => 0,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
	    priority => 30,
    }
	yum::managed_yumrepo { centos5-plus:
	    descr => 'CentOS-$releasever - Plus',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever',
		priority => 15,
	}
    yum::managed_yumrepo { epel:
	    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	    enabled => 1,
		gpgcheck => 1,
        failovermethod => 'priority',
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
	    priority => 16,
    }
	yum::managed_yumrepo { epel-debuginfo:
	    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
        failovermethod => 'priority',
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 16,
    }
    yum::managed_yumrepo { epel-source:
	    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    failovermethod => priority,
        failovermethod => 'priority',
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    	priority => 16,
    }
	yum::managed_yumrepo { epel-testing:
	    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
        failovermethod => 'priority',
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
    }
    yum::managed_yumrepo { epel-testing-debuginfo:
	    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel5&arch=$basearch'
	    enabled => 1,
    	gpgcheck => 1,
        failovermethod => 'priority',
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
    }
	yum::managed_yumrepo { epel-testing-source:
	    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel5&arch=$basearch',
    	enabled => 1,
		gpgcheck => 1,
		failovermethod => priority,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
    }
	yum::managed_yumrepo { kbs-CentOS-Extras:
	    descr => 'CentOS.Karan.Org-EL$releasever - Stable',
        baseurl => 'http://centos.karan.org/el$releasever/extras/stable/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 20,
    }
	yum::managed_yumrepo { kbs-CentOS-Extras-Testing:
	    descr => 'CentOS.Karan.Org-EL$releasever - Testing',
        baseurl => 'http://centos.karan.org/el$releasever/extras/testing/$basearch/RPMS/',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 20,
	}
    yum::managed_yumrepo { kbs-CentOS-Misc:
	    descr => 'CentOS.Karan.Org-EL$releasever - Stable',
        baseurl => 'http://centos.karan.org/el$releasever/misc/stable/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 20,
    }
    yum::managed_yumrepo { kbs-CentOS-Misc-Testing:
	    descr => 'CentOS.Karan.Org-EL$releasever - Testing',
        baseurl => 'http://centos.karan.org/el$releasever/misc/testing/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 20,
	}
}

class yum::prerequisites {
    package{yum-priorities:
        ensure => present,
    } 

	# ensure there are no other repos
    file{yum_repos_d:
        path => '/etc/yum.repos.d/',
        source => "puppet://$server/yum/empty",
        ensure => directory,
        recurse => true,
        purge => true,
        require =>  Package[yum-priorities],
        mode => 0755, owner => root, group => 0;
    }
    #gpg key
	file {rpm_gpg: 
	    path => '/etc/pki/rpm-gpg/',
        source => [ "puppet://$server/yum/${operatingsystem}.${lsbdistrelease}/rpm-gpg/",
                    "puppet://$server/yum/CentOS.5/rpm-gpg/" ],
	    recurse => true,
        purge => true,
		owner => root,
    	group => 0,
	    mode => '600',
    }
}

define yum::managed_yumrepo (
    $descr = 'absent',
    $baseurl = 'absent', 
    $mirrorlist = 'absent',
    $enabled = 0,
    $gpgcheck = 0,
    $gpgkey = 'absent', 
    $failovermethod = 'absent',
    $priority = 99){

    # ensure that everything is setup
    include yum::prerequisites
    
    file{"/etc/yum.repos.d/${name}.repo":
        ensure => file,
        replace => false,
        before => Yumrepo[$name],
        require => [ File[yum_repos_d],
             Package[yum-priorities]
        ],
        mode => 0644, owner => root, group => 0;
    }

    yumrepo{$name:
        descr => $descr,
        baseurl => $baseurl, 
        mirrorlist => $mirrorlist,
        enabled => $enabled,
        gpgcheck => $gpgcheck,
        gpgkey => $gpgkey, 
        failovermethod => $failovermethod,
        priority => $priority,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }    
}
