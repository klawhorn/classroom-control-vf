class memchached {
  package {'memcached':
    ensure  =>  present,
    before  =>  File
  }
file { 'memcached':
  ensure  =>  file,
  path  =>  '/etc/sysconfig/memcached',
  owner =>  'root',
  group =>  'root',
  source  =>  'puppet:///modules/memcached/memcached',
}

service { 'memcached':
  ensure  =>  running,
  enable  =>  true,
}
