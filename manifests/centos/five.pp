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

    yum::managed_yumrepo {contrib:
        descr => 'CentOS-$releasever - Contrib',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 10,
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
        failovermethod => 'priority',
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 16,
    }
    yum::managed_yumrepo { epel-testing:
        descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=$basearch',
        enabled => 0,
        gpgcheck => 1,
        failovermethod => 'priority',
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 17,
    }
    yum::managed_yumrepo { epel-testing-debuginfo:
        descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel5&arch=$basearch',
        enabled => 0,
        gpgcheck => 1,
        failovermethod => 'priority',
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 17,
    }
    yum::managed_yumrepo { epel-testing-source:
        descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel5&arch=$basearch',
        enabled => 0,
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
        enabled => 0,
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
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
        priority => 20,
    }
}
