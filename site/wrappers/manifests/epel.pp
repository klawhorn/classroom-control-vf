class wrappers:: epel {
  class { 'epel':
    epel_testing_enabled => '1',
    epel_sourve_enabled => '1',
  }
}
