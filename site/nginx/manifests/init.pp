class nginx (  
      $package  = nginx::parpms::$package
      $service  = nginx::parpms::$service
      $docroot  = nginx::parpms::$docroot 
      $confdir  = nginx::parpms::$confdir
      $blockdir = nginx::parpms::$blockdir
      $logdir   = nginx::parpms::$logdir
      $owner    = nginx::parpms::$owner
      $group    = nginx::parpms::$group
    ) inherits nginx::parmpms    
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
