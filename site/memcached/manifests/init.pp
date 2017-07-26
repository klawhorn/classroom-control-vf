class memcached {
  package { 'memcached' }
    ensure => present
  }

  file { 'memcached':
    ensure => file,
    path => '/etc/sysconfig/memcached',
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/memcached/memcached',
  }

  service { 'memcached':
    ensure => running,
    enabled => true,
  }
}
