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

define nfsd::deploy_config($source){
    file{"/etc/exports":
        owner => root,
        group => 0,
        mode => 600,
        source => "puppet://$servername/dist/nfsd/exports/$source",
        notify => service["nfsd"],
    }

    file{"/etc/hosts.allow":
        owner => root,
        group => 0,
        mode => 600, 
        source => "puppet://$servername/dist/nfsd/hosts.allow/$source",
        notify => service["portmap"],
    }
}
