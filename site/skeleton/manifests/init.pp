class skeleton {

  file { '/etc/skel':
    ensure => 'directory',
  }

  
  file { 'bashrc':
    ensure => file,
    path   => '/etc/skel/.bashrc',
    source => 'puppet:///modules/skeleton/bashrc',
  }

}
