class nginx::params {
  case $facts['os']['family'] {
    'redhat' , 'debian': {
      $package  = 'nginx'
      $service  = 'nginx'
      #$docroot  = '/var/www'
      $defdocroot  = '/var/www'
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
      $defdocroot  = 'C:/ProgramData/nginx/html'
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
