class nfsd::debian inherits nfsd::base {
    Service[nfsd]{
        name => 'nfs-user-server',
    }
}
