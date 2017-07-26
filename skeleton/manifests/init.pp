class skeleton {

  file { '/etc/skel':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

  file { 'bashrc':
    ensure => file,
    path   => '/etc/skel/.bashrc'
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/skeleton/bashrc'
  }

}
