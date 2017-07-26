class nginx {

  File {
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

  file { 'docroot':
    ensure => directory,
    path   => '/var/www',
    owner  => 'root',
    group  => 'root',
  }
  
  file { 'index.html':
    ensure => file,
    path   => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf':
    ensure => file,
    path   => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { 'default.conf':
    ensure => file,
    path   => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    enable    => true,
    ensure    => running,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
