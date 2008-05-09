# manifests/selinux.pp

class nfsd::selinux {
    case $operatingsystem {
        gentoo: { include nfsd::selinux::gentoo }
        default: { info("No selinux stuff yet defined for your operatingsystem") }
    }
}

class nfsd::selinux::gentoo {
    package{'selinux-nfsd':
        ensure => present,
        category => 'sec-policy',
        require => Package[nfsd],
    }
    selinux::loadmodule {"nfsd": require => Package[selinux-nfsd] }
}

