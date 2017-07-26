class memcached {
  package { 'memcached':
    ensure => present,
    before => File['memcached'],
  }
  
  file { 'memcached':
    ensure => file,
    path   => '/etc/sysconfig/memcached',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/memcached/memcached',
    notify => Service['memcached'],
  }
  
  service { 'memcached':
    ensure => running,
    enable => true,
  }
}
