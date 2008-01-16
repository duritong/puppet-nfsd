# modules/nfsd/manifests/init.pp - manage nfsd stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "nfsd": }

class nfsd {
    service{"nfsd": 
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
        source => "puppet://$servername/dist/nfsdd/exports/$source",
        notify => service["nfsd"],
        require => service["nfsd"],
    }

    file{"/etc/hosts.allow":
        owner => root,
        group => 0,
        mode => 600, 
        source => "puppet://$servername/dist/nfsdd/hosts.allow/$source",
        notify => service["portmap"],
        require => service["portmap"],
    }
}
