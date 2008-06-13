#
# apache module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
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
