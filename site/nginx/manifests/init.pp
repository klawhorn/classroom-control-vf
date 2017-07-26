class nginx {

  $docroot = '/var/www'
  $confdir = '/etc/nginx'
  $uri = 'puppet:///modules/nginx'

  File {
    ensure => file,
    owner => 'root',
    group => 'root',
  }
  
  package { 'nginx':
    ensure => present,
    before => [ 
      File['nginx.conf'],
      File['default.conf'],
      File['index.html']
    ]
  }

  file { $docroot :
    ensure => directory,
  }
  
  file { 'index.html' :
    path   => '${docroot}/index.html',
    source => '${uri}/index.html',
  }
  
  file { 'nginx.conf' :
    path   => '${confdir}/nginx.conf',
    source => '${uri}/nginx.conf',
  }
  
  file { 'default.conf' :
    path   => '${confdir}/conf.d/default.conf',
    source => '${uri}/default.conf',
  }
  
  service { 'nginx' :
    enable    => true,
    ensure    => running,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
