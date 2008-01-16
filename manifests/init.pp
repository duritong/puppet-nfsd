# modules/nfs/manifests/init.pp - manage nfs stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "nfs": }

class nfs {
    service{"nfsd": 
        ensure => running, 
        require => Service["portmap"],
    }
    service{"portmap": 
        ensure => running, 
        hasrestart => true,
    }
}

define nfs::deploy_config($source){
    file{"/etc/exports":
        owner => root,
        group => 0,
        mode => 600,
        source => "puppet://$servername/dist/nfsd/exports/$source",
        notify => service["nfsd"],
        require => service["nfsd"],
    }

    file{"/etc/hosts.allow":
        owner => root,
        group => 0,
        mode => 600, 
        source => "puppet://$servername/dist/nfsd/hosts.allow/$source",
        notify => service["portmap"],
        require => service["portmap"],
    }
}
