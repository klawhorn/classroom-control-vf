class skeleton {
file {"/etc/skel":
   ensure => directory,
   }

file {"basrc":
  ensure => file,
  path => "/etc/skel/.bashrc",
  source => "puppet:///modules/skeleton/bashrc",
  }
}
