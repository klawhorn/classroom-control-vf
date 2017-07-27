class skeleton {
  $skeloc = '/etc/skel'
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/skel':
    ensure => directory,
    path => "${skeloc}",
  }

  file { 'bashrc':
    ensure => file,
    path => "${skeloc}/.bashrc",
    source => 'puppet:///modules/skeleton/bashrc',
  }

}
