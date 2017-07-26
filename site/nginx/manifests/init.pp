class nginx {

  $service  = 'nginx'
  $package  = 'nginx'
  $docroot = 'var/www'
  $confdir = '/etc/nginx'
  $blockdir = "${confdir}/conf.d"
  $uri      = 'puppet://modules/nginx'
  
  package { 'nginx':
    ensure => present,
    before => [ 
      File['nginx.conf'],
      File['default.conf'],
      File['index.html']
    ]
  }
  
  File {
  ensure  =>  file,
  owner   =>  'root',
  group   =>  'root',
  }
  
  file { $docroot:
    ensure => directory,
  }
  
  file { 'index.html':
    path   => '/var/www/index.html',
    source => "${uri}/index.html",
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
    source => "{$uri}/nginx.conf",
  }
  
  file { 'default.conf':
    path   => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    enable    => true,
    ensure    => running,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
Contact GitHub API Training Shop Blog About
© 2017 GitHub, Inc. Terms Privacy Security Status Help
