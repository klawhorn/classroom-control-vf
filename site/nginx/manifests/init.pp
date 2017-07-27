class nginx {
  case $facts['os']['family'] {
    'redhat' : {
    $service  = 'nginx'
    $package  = 'nginx'
    $docroot = 'var/www'
    $confdir = '/etc/nginx'
    $blockdir = "${confdir}/conf.d"
    $logdir   = '/var/log/nginx'
    $owner    = 'root'
    $group    = 'root'
    $uri      = 'puppet:///modules/nginx'
   }
    'windows' :   {
    $service  = 'nginx'
    $package  = 'nginx'
    $docroot  = 'C:/ProgramData/nginx/html'
    $confdir  = 'C:/ProgramData/nginx'
    $blockdir = "${confdir}/conf.d"
    $logdir   = "${confdir}/logs"
    $owner    = 'Administrator'
    $group    = 'Administrators'
}
    
    default : {
      fail("Module ${module_name} is not supported on ${facts['os']['family']}")
    }
  }

  
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
  owner   =>  $owner,
  group   =>  $group,
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
      confdir   =>  $confdir,
      blockdir  =>  $blockdir,
      logdir    =>  $logdir,
      user      =>  $user,
    }),
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
