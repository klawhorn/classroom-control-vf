class nginx (
  String $package  = $nginx::params::package,
  String $service  = $nginx::params::service,
  String $docroot  = $nginx::params::docroot,
  String $confdir  = $nginx::params::confdir,
  String $blockdir = $nginx::params::blockdir,
  String $logdir   = $nginx::params::logdir,
  String $owner    = $nginx::params::owner,
  String $group    = $nginx::params::group,
  String $user     = $nginx::params::user,
) inherits nginx::params{
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
    owner  => $owner,
    group  => $group,
  }
  
  file { $docroot:
    ensure => directory,
  }
  
  file { 'index.html':
    path   => "${docroot}/index.html",
    content => epp('nginx/index.html.epp'),
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
    content => epp('nginx/nginx.conf.epp', {
      confdir  => $confdir,
      blockdir => $blockdir,
      logdir   => $logdir,
      user     => $user,
    }),
  }
  
  file { 'default.conf':
    path   => "${blockdir}/default.conf",
    content => epp('nginx/default.conf.epp', { docroot => $docroot, }),
  }
  
  service { $service:
    enable    => true,
    ensure    => running,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
