class nfsd::centos inherits nfsd::base {
  file{'/etc/sysconfig/nfs':
    source => [ "puppet://$server/files/nfsd/sysconfig/${fqdn}/nfs",
                "puppet://$server/files/nfsd/sysconfig/nfs",
                "puppet://$server/modules/nfsd/sysconfig/nfs" ],
        notify => Service["nfs"],
        owner => root, group => 0, mode => 644;
  }
}
