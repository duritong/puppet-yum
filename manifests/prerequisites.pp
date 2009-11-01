class yum::prerequisites {
    package{yum-priorities:
        ensure => present,
    }

    # ensure there are no other repos
    file{yum_repos_d:
        path => '/etc/yum.repos.d/',
        source => "puppet://$server/modules/yum/empty",
        ensure => directory,
        recurse => true,
        purge => true,
        ignore => '\.ignore',
        require =>  Package[yum-priorities],
        mode => 0755, owner => root, group => 0;
    }
    #gpg key
    file {rpm_gpg:
        path => '/etc/pki/rpm-gpg/',
        source => [ "puppet://$server/modules/yum/${operatingsystem}.${lsbdistrelease}/rpm-gpg/",
                    "puppet://$server/modules/yum/CentOS.5/rpm-gpg/" ],
        recurse => true,
        purge => true,
        owner => root,
        group => 0,
        mode => '600',
    }
}
