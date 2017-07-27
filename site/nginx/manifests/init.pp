class nginx (
  $docroot,
){
  case $facts['os']['family'] {
    'redhat' , 'debian': {
      $package  = 'nginx'
      $service  = 'nginx'
      #$docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $blockdir = "${confdir}/conf.d"
      $logdir   = '/var/log/nginx'
      $owner    = 'root'
      $group    = 'root'
    }
    'windows' : {
      $package  = 'nginx'
      $service  = 'nginx'
      #$docroot  = 'C:/ProgramData/nginx/html'
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

  $user = $facts['os']['family'] ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
    default   => 'nginx',
  }
  
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
