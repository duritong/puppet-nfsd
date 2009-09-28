class nfsd::base {
    # we configure every nfs server as nfs client
    include ::nfs 

    file{"/etc/exports":
        source => [ "puppet://$server/files/nfsd/exports/${fqdn}/exports",
                    "puppet://$server/files/nfsd/exports/exports",
                    "puppet://$server/nfsd/exports/exports" ],
        notify => Service["nfs"],
        owner => root, group => 0, mode => 600;
    }   

    service{"nfs": 
        enable => true,
        ensure => running, 
        require => Service["portmap"],
        hasstatus => true,
    }
}
