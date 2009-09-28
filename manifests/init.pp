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

class nfsd {
    case $operatingsystem {
        debian: { include nfsd::debian }
        default: { include nfsd::base }
    }
    if $use_shorewall {
      include shorewall::rules::nfsd
    }
}
