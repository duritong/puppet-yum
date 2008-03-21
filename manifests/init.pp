# modules/centos_repos/manifests/init.pp - manage centos_repos
# Copyright (C) 2007 admin@immerda.ch
# 

#modules_dir { "centos_repos": }

class centos_repos {

  # package stuff to prio

  package { yum-priorities:
                ensure => present
        }

        yumrepo { base:
                priority => 1,
                require => Package[yum-priorities],
        }
        yumrepo { updates:
                priority => 1,
                require => Package[yum-priorities],
        }
        yumrepo { addons:
                priority => 1,
                require => Package[yum-priorities],
        }
        yumrepo { extras:
                priority => 1,
                require => Package[yum-priorities],
        }
        yumrepo { centosplus:
                priority => 10,
                require => Package[yum-priorities],
        }
        yumrepo { contrib:
                priority => 10,
                require => Package[yum-priorities],
        }

  yumrepo { dlutter-rhel5:
    descr => "Unsupported RHEL5 packages (lutter)",
    baseurl => 'http://people.redhat.com/dlutter/yum/rhel/5/$basearch',
    enabled => 1,
    gpgcheck => 0,
  }
  yumrepo { dlutter-rhel4:
    descr => 'Unsupported RHEL4 packages (lutter)',
    baseurl => 'http://people.redhat.com/dlutter/yum/rhel/4/$basearch',
    enabled => 0,
    gpgcheck => 0,
  }
  yumrepo { dlutter-fedora:
    descr => 'Additional Fedora packages (lutter)',
    baseurl => 'http://people.redhat.com/dlutter/yum/fedora/$releasever/$basearch',
    enabled => 0,
    gpgcheck => 0,
  }
  yumrepo { dlutter-fedora-development:
    descr => 'Additional Fedora packages (lutter)',
    baseurl => 'http://people.redhat.com/dlutter/yum/development/$basearch/',
    enabled => 0,
    gpgcheck => 0,
  }
  yumrepo { dlutter-source:
    descr => 'Sources for additional test packages (lutter)',
    baseurl => 'http://people.redhat.com/dlutter/yum/SRPMS/',
    enabled => 0,
    gpgcheck => 0,
  }

	#gpg key
	file {rpm_gpg: 
		path => "/etc/pki/rpm-gpg/",
		source => "puppet://$server/centos_repos/rpm-gpg/",
		recurse => true,
		owner => root,
		group => 0,
		mode => '600',
	}
		
      yumrepo { rpmforge-rhel5:
      		descr => "RPMForge RHEL5 packages",
          	baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
	      	enabled => 1,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
		priority => 30,
		require => [ File[rpm_gpg], 
				Package[yum-priorities]
			],
	}
	yumrepo {centos5-atrpms:
		descr => "CentOS $releasever - $basearch - ATrpms",
          	baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
	      	enabled => 1,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
		priority => 30,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { centos5-plus:
		descr => "CentOS-$releasever - Plus",
          	mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever',
		priority => 15,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { epel:
		descr => "Extra Packages for Enterprise Linux $releasever - $basearch",
          	mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	      	enabled => 1,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 16,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { epel-debuginfo:
		descr => "Extra Packages for Enterprise Linux $releasever - $basearch - Debug",
          	mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 16,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { epel-source:
		descr => "Extra Packages for Enterprise Linux $releasever - $basearch - Source",
          	mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
	      	enabled => 0,
		gpgcheck => 1,
		failovermethod => priority,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 16,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { epel-testing:
		descr => "Extra Packages for Enterprise Linux $releasever - Testing - $basearch",
          	baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { epel-testing-debuginfo:
		descr => "Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug",
          	baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch/debug',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { epel-testing-source:
		descr => "Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source",
          	baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/SRPMS',
	      	enabled => 0,
		gpgcheck => 1,
		failovermethod => priority,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { kbs-CentOS-Extras:
		descr => "CentOS.Karan.Org-EL$releasever - Stable",
          	baseurl => 'http://centos.karan.org/el$releasever/extras/stable/$basearch/RPMS/',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 20,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { kbs-CentOS-Extras-Testing:
		descr => "CentOS.Karan.Org-EL$releasever - Testing",
          	baseurl => 'http://centos.karan.org/el$releasever/extras/testing/$basearch/RPMS/',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 20,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { kbs-CentOS-Misc:
		descr => "CentOS.Karan.Org-EL$releasever - Stable",
          	baseurl => 'http://centos.karan.org/el$releasever/misc/stable/$basearch/RPMS/',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 20,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
	yumrepo { kbs-CentOS-Misc-Testing:
		descr => "CentOS.Karan.Org-EL$releasever - Testing",
          	baseurl => 'http://centos.karan.org/el$releasever/misc/testing/$basearch/RPMS/',
	      	enabled => 0,
		gpgcheck => 1,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 20,
                require => [ File[rpm_gpg],
                                Package[yum-priorities]
                        ],
	}
}
