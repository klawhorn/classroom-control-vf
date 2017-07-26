class nginx {
  $package  = 'nginx'
  $service  = 'nginx'
  $docroot  = '/var/www'
  $confdir  = '/etc/nginx'
  $blockdir = "${confdir}/conf.d"
  $uri      = 'puppet:///modules/nginx'
  
  package { $package:
    ensure => present,
    before => [ 
      File['nginx.conf'],
      File['default.conf'],
      File['index.html']
    ]
  }
  
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
  }
  
  file { $docroot:
    ensure => directory,
  }
  
  file { 'index.html':
    path   => "${docroot}/index.html",
    source => "${uri}/index.html",
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
    source => "${uri}/nginx.conf",
  }
  
  file { 'default.conf':
    path   => "${blockdir}/default.conf",
    source => "${uri}/default.conf",
  }
  
  service { $service:
    enable    => true,
    ensure    => running,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
