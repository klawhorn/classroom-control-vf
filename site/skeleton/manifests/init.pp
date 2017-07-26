class skeleton {
  file { '/etc/skel':
    ensure => directory,
    path => '/etc/skel',
    owner => 'root',
    group => 'root',
  }

  file { 'bashrc':
    ensure => file,
    path => '/etc/skel/.bashrc',
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/skeleton/bashrc',
  }

}
