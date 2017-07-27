class profile::blog {
  class { 'apache': }
  class {'apache::mod::php': }
}
