# modules/nfsd/manifests/init.pp - manage nfsd stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# adpated by  Puzzle ITC - haerry+puppet(at)puzzle.ch
#
# This module manages an nfs server. to mange an nfs 
# client please look into the module nfs

# modules_dir { "nfsd": }

class nfsd {
    case $operatingsystem {
        debian: { include nfsd::debian }
        default: { include nfsd::base }
    }

    if $selinux {
        include nfsd::selinux
    }
}

class nfsd::base {
    # we configure every nfs server as nfs client
    include nfs 
    
    service{"nfs": 
        ensure => running, 
        require => Service["portmap"],
        hasstatus => true,
    }
}

define nfsd::deploy_config(){
    file{"/etc/exports":
        source => [ "puppet://$server/files/nfsd/exports/${fqdn}/exports",
                    "puppet://$server/files/nfsd/exports/exports",
                    "puppet://$server/nfsd/exports/exports" ],
        notify => Service["nfs"],
        owner => root, group => 0, mode => 600;
    }
}

class nfsd::debian inherits nfsd::base {
    Service[nfsd]{
        name => 'nfs-user-server',
    }
}
