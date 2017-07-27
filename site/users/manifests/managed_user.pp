define users::managed_user (
  $group = $title
) {
  $home = $facts['os']['family'] ? {
    'windows' => 'C:/Users',
    default   => '/home'
  }
  user { $title:
    ensure => present
  }
  file { "/home/$title":
    ensure => directory
  }
}
