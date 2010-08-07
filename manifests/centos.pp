class nfsd::centos inherits nfsd::base {
  file{'/etc/sysconfig/nfs':
    source => [ "puppet:///modules/site-nfsd/sysconfig/${fqdn}/nfs",
                "puppet:///modules/site-nfsd/sysconfig/nfs",
                "puppet:///modules/nfsd/sysconfig/nfs" ],
        notify => Service["nfs"],
        owner => root, group => 0, mode => 644;
  }
}
