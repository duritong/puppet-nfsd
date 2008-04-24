# modules/nfsd/manifests/init.pp - manage nfsd stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "nfsd": }

class nfsd {
    service{"nfsd": 
        name => $operatingsystem ? {
            centos => 'nfs',
            debian => 'nfs-user-server',
            default => 'nfsd',
        },
        ensure => running, 
        require => Service["portmap"],
    }
    service{"portmap": 
        ensure => running, 
        hasrestart => true,
    }
}

define nfsd::deploy_config(){
    file{"/etc/exports":
        owner => root,
        group => 0,
        mode => 600,
        source => [ "puppet://$server/files/nfsd/exports/${fqdn}/exports",
                    "puppet://$server/files/nfsd/exports/exports",
                    "puppet://$server/nfsd/exports/exports" ],
        notify => Service["nfsd"],
    }
}
