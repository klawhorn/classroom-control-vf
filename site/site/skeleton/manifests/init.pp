class skeleton {
   file { '/etc/skel':
    ensure => directory,
    owner => 'root',
    group => 'root',
  }
  
  file { 'bashrc':
   ensure => file,
   path => 'etc/skel/.bashrc',
   source => 'puppet://modules/skeleton/bashrc',
  }

}
