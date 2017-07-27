class skeleton {:
file {"/etc/skel"
   ensure => directory
   }

file {"basrc"
  ensure => file,
  source => "puppet:///modules/skeleton/bashrc"
  }
}
