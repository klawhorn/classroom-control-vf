class skeleton {

file {'/etc/skel':
   ensure => directory,
   owner => 'root',
   group => 'root',
   }
 
file {'/etc/skel/.bashrc',
   ensure => file,
   owner => 'root',
   group => 'root',
   require => '/etc/skel',
   source => 'puppet:///site/skeleton/bashrc
   }
   
 }
