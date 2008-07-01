# manifests/updatesd.pp

class yum::updatesd {
    package{'yum-updatesd':
        ensure => present,
    }

    service{'yum-updatesd':
        ensure => running,
        enable => true,
        require => Package['yum-updatesd'],
    }
}
